import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/modules/register/cubit/states.dart';
import 'package:warehouse_app/shared/network/remote/dio_helper.dart';
import 'package:warehouse_app/shared/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData passwordSuffix = Icons.visibility_outlined;
  bool isPassword = true;
  changePasswordViability() {
    isPassword = !isPassword;
    passwordSuffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterViabilityChangeState());
  }

  List<String> branches = [];

  void getBranches() {
    emit(GetBranchesLoadingState());
    DioHelper.getData(url: '/branches').then((value) {
      value.data.forEach((branch) {
        branches.add(branch["name"]);
      });
      emit(GetBranchesSuccessState());
    }).catchError((onError) {
      emit(GetBranchesErrorState(error: onError));
    });
  }


  void userRegister({
    required String firstName,
    required String lastName,
    required int sesaId,
    required String email,
    required String phone,
    required String password,
    required String branchName,
  }) async {
    emit(RegisterLoadingState());

    emit(RegisterLoadingState());
    DioHelper.postData(
      url: "signup",
      data: {
        "branch_name": branchName,
        "sesa_id": sesaId,
        "branch_id": 0,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "role": "user",
        "password": password,
      },
    ).then((value) {
      emit(RegisterSuccessState(message: value.data["message"]));
    }).catchError(
      (error) {
        debugPrint(error.toString());
        emit(RegisterErrorState(error: error.toString()));
      },
    );
  }

}
