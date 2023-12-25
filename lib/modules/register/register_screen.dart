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

  void _registerAndSignIn(context) {
    if (_textValidation()) {
      RegisterCubit.get(context).userRegister(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        phone: _phoneController.text,
        branchName: _branchController!,
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
                      child: Column(
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
                          // defaultTextFormField(
                          //   controller: _branchController,
                          //   type: TextInputType.text,
                          //   hint: "Branch name",
                          //   prefix: Icons.assignment_ind_outlined,
                          // ),
                          DefaultButtonDropDownField(
                            hint: "Branch name",
                            items: cubit.branches,
                            value: _branchController,
                            onChanged_:  (String? value) {
                              // This is called when the user selects an item.
                              _branchController = value!;
                              cubit.selectBranch();
                            },
                          ),
                          // DropdownButtonFormField(
                          //   validator: (value) =>
                          //       value == null ? 'field required' : null,
                          //   onChanged: (String? value) {
                          //     // This is called when the user selects an item.
                          //     _branchController = value!;
                          //     cubit.selectBranch();
                          //   },
                          //   alignment: Alignment.bottomCenter,
                          //   decoration: InputDecoration(
                          //     enabledBorder: const OutlineInputBorder(
                          //       borderSide: BorderSide(color: Colors.white),
                          //     ),
                          //     hintText: "Branch name",
                          //     hintStyle: TextStyle(
                          //       color: Colors.grey[500],
                          //     ),
                          //     prefixIcon: Icon(Icons.assignment_ind_outlined),
                          //     prefixIconColor: Colors.grey.shade500,
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Colors.grey.shade400,
                          //       ),
                          //     ),
                          //     fillColor: Colors.grey.shade200,
                          //     filled: true,
                          //   ),
                          //   value: _branchController,
                          //   items: cubit.branches
                          //       .map<DropdownMenuItem<String>>((String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(
                          //         value,
                          //         style: const TextStyle(color: Colors.black),
                          //       ),
                          //     );
                          //   }).toList(),
                          //   isExpanded: true,
                          //   dropdownColor: Colors.grey.shade200,
                          // ),

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
          );
        },
      ),
    );
  }
}
