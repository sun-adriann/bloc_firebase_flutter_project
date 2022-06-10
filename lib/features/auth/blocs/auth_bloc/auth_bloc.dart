import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/i_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  AuthBloc(IAuthRepository authRepository)
      : _authRepository = authRepository,
        super(const _Initial()) {
    on<AuthEvent>(_eventHandler);
  }

  Future<void> _eventHandler(AuthEvent event, Emitter<AuthState> emit) {
    return event.map(
      signInWithEmailAndPassword: (e) =>
          _signInWithEmailAndPassword(state, emit, e),
    );
  }

  Future<void> _signInWithEmailAndPassword(
    AuthState state,
    Emitter<AuthState> emit,
    _SignInWithEmailAndPassword e,
  ) async {
    try {
      emit(const AuthState.signingIn());

      await _authRepository.signInWithEmailAndPassword(
        email: e.email,
        password: e.password,
      );

      emit(const AuthState.authenticated());
    } catch (e) {
      if (e is FirebaseException) {
        emit(AuthState.failed(message: e.message));
      }
    }
  }
}
