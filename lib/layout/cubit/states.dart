sealed class AppStates {}

class AppInitialState extends AppStates {}
//Get Data
class AppGetDataLoadingState extends AppStates {}

class AppGetDataSuccessState extends AppStates {}

class AppGetDataErrorState extends AppStates {
  final String error;
  AppGetDataErrorState({required this.error});
}

class UserGetDataLoadingState extends AppStates {}

class UserGetDataSuccessState extends AppStates {}

class UserGetDataErrorState extends AppStates {
  final String error;
  UserGetDataErrorState({required this.error});
}


//Email Update Verification
class AppUpdateEmailVerificationLoadingState extends AppStates {}

class AppUpdateEmailVerificationSuccessState extends AppStates {}

class AppUpdateEmailVerificationDidNotSuccessState extends AppStates {}

class AppUpdateEmailVerificationErrorState extends AppStates {
  final String error;
  AppUpdateEmailVerificationErrorState({required this.error});
}

class AppChangeBottomNavState extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppSelectProfileImageSuccessState extends AppStates {}

class AppSelectProfileImageErrorState extends AppStates {}

class AppSelectBannerImageSuccessState extends AppStates {}

class AppSelectBannerImageErrorState extends AppStates {}
