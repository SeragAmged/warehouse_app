import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:warehouse_app/modules/login/cubit/states.dart';
import 'package:warehouse_app/shared/components/functions.dart';
import 'package:warehouse_app/shared/components/variables.dart';

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

  // void userLogin({required String email, required String password}) async {
  //   {
  //     emit(LoginLoadingState());
  //     DioHelper.postData(url: '/token', data: {
  //       'username': email,
  //       'password': password,
  //       "grant_type": "password",
  //       "scope": "employee", // Specify the desired scope if applicable
  //       "client_id": "", // Replace with your client ID
  //       "client_secret": "",
  //     }).then(
  //       (value) {
  //         tokenSaveLocal(value.data['access_token']);
  //         print(value.data);
  //         emit(LoginSuccessState());
  //       },
  //     ).catchError(
  //       (error) {
  //         print(error);
  //         emit(LoginErrorState(error: error.toString()));
  //       },
  //     );
  //   }
  // }

  Future<void> userLogin(
      {required String email, required String password}) async {
    emit(LoginLoadingState());
    final tokenEndpoint = Uri.parse('http://192.168.1.5:8080/login');
    oauth2
        .resourceOwnerPasswordGrant(
      tokenEndpoint,
      email,
      password,
    )
        .then(
      (value) {
        tokenSaveLocal(value.credentials.accessToken);
        print(token);
        emit(LoginSuccessState());
      },
    ).catchError((error) {
      emit(LoginErrorState(error: error.toString()));
    });

    // Emit login success state
  }
}
