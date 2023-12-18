sealed class AppStates {}

class AppInitialState extends AppStates {}
//Get Data
class AppGetDataLoadingState extends AppStates {}

class AppGetDataSuccessState extends AppStates {}

class AppGetDataErrorState extends AppStates {
  final String error;
  AppGetDataErrorState({required this.error});
}
//Email Verification
class AppEmailVerificationLoadingState extends AppStates {}

class AppEmailVerificationSuccessState extends AppStates {}

class AppEmailVerificationErrorState extends AppStates {
  final String error;
  AppEmailVerificationErrorState({required this.error});
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
