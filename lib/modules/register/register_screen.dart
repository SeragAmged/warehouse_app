import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/modules/login/login_screen.dart';
import 'package:warehouse_app/modules/register/cubit/cubit.dart';
import 'package:warehouse_app/modules/register/cubit/states.dart';
import 'package:warehouse_app/shared/components/functions.dart';

import '../../shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _sesaIdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? _branchController;

  bool _textValidation() => _formKey.currentState!.validate();

  String? _confirmPasswordValidation() {
    return _confirmPasswordController.text != _passwordController.text
        ? "Doesn't match your password !"
        : null;
  }

  void _register(context) {
    if (_textValidation()) {
      RegisterCubit.get(context).userRegister(
        branchName: _branchController!,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        sesaId: int.parse(_sesaIdController.text),
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      );
    }
  }

  void _goToSignIn(context) {
    navigateTo(context, LoginScreen());
    Feedback.forTap(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit()..getBranches(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            toast(
              context: context,
              message: state.message,
              state: ToastState.success,
            );
            navigateToWithReplacement(context, LoginScreen());
          }
          if (state is RegisterErrorState) {
            toast(
              context: context,
              message: state.error,
              state: ToastState.error,
            );
          }
          if (state is RegisterErrorState) {
            toast(
              context: context,
              message: state.error,
              state: ToastState.error,
            );
          }
          if (state is GetBranchesErrorState) {
            toast(
              context: context,
              message: state.error,
              state: ToastState.error,
            );
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: ConditionalBuilder(
                        condition: cubit.branches.isEmpty,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        fallback: (context) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 25),
                            Text(
                              "Register",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Text(
                              "Let's make you a new account",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 25),
                            DefaultButtonDropDownField(
                              hint: "Branch name",
                              items: cubit.branches,
                              value: _branchController,
                              onChanged_: (String? value) {
                                _branchController = value!;
                              },
                            ),
                            const SizedBox(height: 10),
                            defaultTextFormField(
                              controller: _firstNameController,
                              type: TextInputType.name,
                              hint: "First name",
                              prefix: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 10),
                            defaultTextFormField(
                              controller: _lastNameController,
                              type: TextInputType.name,
                              hint: "Last name",
                              prefix: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 10),
                            defaultTextFormField(
                              controller: _sesaIdController,
                              type: TextInputType.number,
                              hint: "sesa Id",
                              prefix: Icons.assignment_ind_outlined,
                            ),
                            const SizedBox(height: 10),
                            defaultTextFormField(
                              controller: _emailController,
                              type: TextInputType.emailAddress,
                              hint: "Email",
                              prefix: Icons.alternate_email_sharp,
                              isCustomValidator: true,
                              customValidator: (String? value) {
                                // Basic email validation
                                if (value!.isEmpty) {
                                  return 'Please enter an email address';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
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
                              obscureText:
                                  RegisterCubit.get(context).isPassword,
                              suffix: RegisterCubit.get(context).passwordSuffix,
                              suffixPressed: () => RegisterCubit.get(context)
                                  .changePasswordViability(),
                            ),
                            const SizedBox(height: 10),
                            defaultTextFormField(
                              controller: _confirmPasswordController,
                              type: TextInputType.text,
                              hint: "confirm password",
                              obscureText:
                                  RegisterCubit.get(context).isPassword,
                              isCustomValidator: true,
                              customValidator: (value) =>
                                  _confirmPasswordValidation(),
                              onFieldSubmitted: (value) => _register(context),
                            ),
                            const SizedBox(height: 25),
                            Row(
                              children: [
                                Expanded(
                                  child: DefaultButton(
                                    onPressed: () =>
                                        state is RegisterLoadingState
                                            ? null
                                            : _register(context),
                                    child: ConditionalBuilder(
                                      condition: state is RegisterLoadingState,
                                      builder: (context) =>
                                          const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      fallback: (context) => const Text(
                                        "Register",
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
                            const SizedBox(height: 5),
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
                                  onTap: () => _goToSignIn(context),
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
          );
        },
      ),
    );
  }
}
