part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.signingIn() = _SigningIn;
  const factory AuthState.signingOut() = _SigningOut;
  const factory AuthState.failed({String? message}) = _Failed;
}
