import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  IconData passwordSuffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordViability() {
    isPassword = !isPassword;
    passwordSuffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginViabilityChangeState());
  }

  void userLogin({required String email, required String password}) async{
    {
      emit(LoginLoadingState());
      await Future.delayed(const Duration(seconds: 2));
      emit(LoginSuccessState());
      // emit(LoginErrorState(error: error.toString()));
    }
  }
}
