abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterViabilityChangeState extends RegisterStates {}

class GetBranchesLoadingState extends RegisterStates {}

class GetBranchesSuccessState extends RegisterStates {}

class GetBranchesErrorState extends RegisterStates {
  final String error;
  GetBranchesErrorState({required this.error});
}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final String message;
  RegisterSuccessState({required this.message});
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState({required this.error});
}
