abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterViabilityChangeState extends RegisterStates {}

class SelectBranch extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState({required this.error});
}

class UserCreateSuccessState extends RegisterStates {}

class UserCreateErrorState extends RegisterStates {
  final String error;
  UserCreateErrorState({required this.error});
}
