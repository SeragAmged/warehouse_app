import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/layout/app_layout.dart';
import 'package:warehouse_app/modules/login/cubit/cubit.dart';
import 'package:warehouse_app/modules/login/cubit/states.dart';
import 'package:warehouse_app/modules/register/register_screen.dart';
import 'package:warehouse_app/shared/components/components.dart';
import 'package:warehouse_app/shared/components/functions.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _textValidation() => _formKey.currentState!.validate();

  void _forgetPassword(context) {
    navigateTo(context, const Placeholder());
    Feedback.forTap(context);
  }

  void _signIn(context) {
    if (_textValidation()) {
      LoginCubit.get(context).userLogin(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  void _register(context) {
    navigateTo(context, RegisterScreen());
    Feedback.forTap(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            toast(
              context: context,
              message: state.error,
              state: ToastState.error,
            );
          }
          if (state is LoginSuccessState) {
            navigateToWithReplacement(context, const AppLayout());
          }
        },
        builder: (context, state) => Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          "Welcome back you've been missed!",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 25),
                        defaultTextFormField(
                          controller: _emailController,
                          type: TextInputType.emailAddress,
                          hint: "Email",
                          prefix: Icons.alternate_email_sharp,
                        ),
                        const SizedBox(height: 10),
                        defaultTextFormField(
                          controller: _passwordController,
                          type: TextInputType.text,
                          onFieldSubmitted: (value) => _signIn(context),
                          hint: "password",
                          prefix: Icons.lock_outline_rounded,
                          obscureText: LoginCubit.get(context).isPassword,
                          suffix: LoginCubit.get(context).passwordSuffix,
                          suffixPressed: () =>
                              LoginCubit.get(context).changePasswordViability(),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => _forgetPassword(context),
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: DefaultButton(
                                  onPressed: () => state is LoginLoadingState
                                      ? null
                                      : _signIn(context),
                                  child: ConditionalBuilder(
                                    condition: state is LoginLoadingState,
                                    builder: (context) =>
                                        const CircularProgressIndicator(
                                            color: Colors.white),
                                    fallback: (context) => const Text(
                                      "Sign in",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () => _register(context),
                              child: const Text(
                                "Register now",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
