import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/custom_textfield.dart';
import '../../home/home_view.dart';
import '../blocs/auth_bloc/auth_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeMap(
            authenticated: (e) {
              emailController.clear();
              passwordController.clear();

              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const HomeView(),
              ));

              return;
            },
            signingIn: (e) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Dialog(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(18.0),
                          child: CircularProgressIndicator(),
                        ),
                        Text("Loading"),
                      ],
                    ),
                  );
                },
              );

              return;
            },
            failed: (e) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.message ?? 'Error')),
              );
              return;
            },
            orElse: () {},
          );
        },
        child: Form(
          key: formKey,
          child: Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 28.0),
                  CustomTextfield(
                    controller: emailController,
                    labelText: 'Email',
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextfield(
                    controller: passwordController,
                    labelText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 24.0),
                  CustomButton(
                    text: 'Sign in',
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(AuthEvent.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
