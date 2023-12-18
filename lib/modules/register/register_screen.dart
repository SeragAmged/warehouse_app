import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/layout/app_layout.dart';
import 'package:warehouse_app/modules/login/login_screen.dart';
import 'package:warehouse_app/modules/register/cubit/cubit.dart';
import 'package:warehouse_app/modules/register/cubit/states.dart';
import 'package:warehouse_app/shared/components/functions.dart';

import '../../shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _textValidation() => _formKey.currentState!.validate();

  String? _confirmPasswordValidation() {
    return _confirmPasswordController.text != _passwordController.text
        ? "Doesn't match your password !"
        : null;
  }

  void _registerAndSignIn(context) {
    if (_textValidation()) {
      RegisterCubit.get(context).userRegister(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        phone: _phoneController.text,
        id: int.parse(_idController.text),
      );
    }
  }

  void _signIn(context) {
    navigateTo(context, LoginScreen());
    Feedback.forTap(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is UserCreateSuccessState) {
            navigateToWithReplacement(context, const AppLayout());
          }
          if (state is RegisterErrorState) {
            toast(
              context: context,
              message: state.error,
              state: ToastState.error,
            );
          }
          if (state is UserCreateErrorState) {
            toast(
              context: context,
              message: state.error,
              state: ToastState.error,
            );
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 25),
                        // const Icon(
                        //   IconBroken.profile,
                        //   size: 150,
                        // ),
                        Text(
                          "Register",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        // const SizedBox(height: 15),
                        Text(
                          "Let's make you a new account",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 25),
                        defaultTextFormField(
                          controller: _idController,
                          type: TextInputType.number,
                          hint: "id",
                          prefix: Icons.assignment_ind_outlined,
                        ),
                        const SizedBox(height: 10),
                        defaultTextFormField(
                          controller: _nameController,
                          type: TextInputType.name,
                          hint: "Name",
                          prefix: Icons.person_outline_rounded,
                        ),
                        const SizedBox(height: 10),
                        defaultTextFormField(
                          controller: _emailController,
                          type: TextInputType.emailAddress,
                          hint: "Email",
                          prefix: Icons.alternate_email_sharp,
                        ),
                        const SizedBox(height: 10),
                        defaultTextFormField(
                          controller: _phoneController,
                          type: TextInputType.phone,
                          hint: "phone",
                          prefix: Icons.phone_outlined,
                        ),
                        const SizedBox(height: 10),
                        defaultTextFormField(
                          controller: _passwordController,
                          type: TextInputType.text,
                          hint: "password",
                          prefix: Icons.lock_outline_rounded,
                          obscureText: RegisterCubit.get(context).isPassword,
                          suffix: RegisterCubit.get(context).passwordSuffix,
                          suffixPressed: () => RegisterCubit.get(context)
                              .changePasswordViability(),
                        ),
                        const SizedBox(height: 10),
                        defaultTextFormField(
                          controller: _confirmPasswordController,
                          type: TextInputType.text,
                          hint: "confirm password",
                          obscureText: RegisterCubit.get(context).isPassword,
                          isCustomValidator: true,
                          customValidator: (value) =>
                              _confirmPasswordValidation(),
                          onFieldSubmitted: (value) =>
                              _registerAndSignIn(context),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: DefaultButton(
                                onPressed: () => state is RegisterLoadingState
                                    ? null
                                    : _registerAndSignIn(context),
                                child: ConditionalBuilder(
                                  condition: state is RegisterLoadingState,
                                  builder: (context) =>
                                      const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  fallback: (context) => const Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () => _signIn(context),
                              child: const Text(
                                "Sign in",
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
