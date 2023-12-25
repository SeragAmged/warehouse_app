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

  List<String> branches = ["Branch A", "Branch B", "Branch C", "Branch D"];

/*

{
  "branch_id": 0,
  "role": "user",
  "employee_name": "string",
  "employee_phone_number": "string",
  "password": "string",
  "email": "string"
}
 */
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String branchName,
  }) async {
    emit(RegisterLoadingState());

    DioHelper.postData(url: employees, data: {
      "branch_id": branchName,
      "role": "user",
      "employee_name": name,
      "employee_phone_number": phone,
      "password": password,
      "email": email,
    }).then((value) {}).catchError((error) {});

    // func().then((value) {
    //   // uIdSaveLocal(value.user!.uid);
    //   userCreate(
    //     email: email,
    //     name: name,
    //     phone: phone,
    //     uId: value.user!.uid,
    //   );
    // }).catchError(
    //   (error) {
    //     debugPrint(error.toString());
    //     emit(RegisterErrorState(error: error.toString()));
    //   },
    // );
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    // UserModel model = UserModel(
    //   uId: uId,
    //   name: name,
    //   email: email,
    //   phone: phone,
    //   banner:
    //       "https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg",
    //   bio: "Write your bio ...",
    //   image:
    //       "https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg",
    //   isEmailVerified: false,
    // );
    // FirebaseFirestore.instance
    //     .collection(usersCollection)
    //     .doc(uId)
    //     .set(model.toMap())
    //     .then((value) => emit(UserCreateSuccessState()))
    //     .catchError((error) {
    //   debugPrint(error.toString());
    //   emit(UserCreateErrorState(error: error.toString()));
    // });
  }

  void register() {
    DioHelper.postData(url: employees, data: {
      "branch_id": 2,
      "role": "user",
      "employee_name": "string",
      "employee_phone_number": "1231gdgdgd3245646",
      "password": "string",
      "email": "jiofgjilgxnklxggdgdggml;"
    }).then((value) {
      print(value.data);
    }).catchError(() {});
  }
}
