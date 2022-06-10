import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'config/injection_modules.dart';

import 'features/auth/blocs/bloc/auth_bloc.dart';
import 'features/auth/views/sign_in_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// If you see an error in the line below, run `flutterfire configure` on your terminal
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeDependencyInjection();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase auth using bloc, freezed, and injectable',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: const SignInView(),
      ),
    );
  }
}
