import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/models/user_model.dart';
import 'package:warehouse_app/modules/login/cubit/states.dart';
import 'package:warehouse_app/shared/components/functions.dart';
import 'package:warehouse_app/shared/network/remote/dio_helper.dart';
import 'package:warehouse_app/shared/network/remote/end_points.dart';

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

  UserModel? userModel;
  void userLogin({required String email, required String password}) async {
    {
      emit(LoginLoadingState());
      DioHelper.postData(url: '/token', data: {
        'username': email,
        'password': password,
      }).then(
        (value) {
          if (value.data['access_token']) {
            DioHelper.postData(
              url: '/employees/me',
              data: {},
              token: value.data['access_token'],
            ).then(
              (value) {
                print("a7a 0");
                tokenSaveLocal(value.data['access_token']);
                userModel = UserModel.fromJson(value.data);
                emit(LoginSuccessState());
              },
            ).catchError(
              (error) {
                print("a7a 1");

                emit(LoginErrorState(error: error.toString()));
              },
            );
          }
        },
      ).catchError(
        (error) {
          print("a7a 2");

          emit(LoginErrorState(error: error.toString()));
        },
      );
    }
  }
}
