import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/layout/cubit/states.dart';
import 'package:warehouse_app/modules/items/items_screen.dart';
import 'package:warehouse_app/modules/my_items/my_items_screen.dart';
import 'package:warehouse_app/modules/qr/qr_screen.dart';
import 'package:warehouse_app/modules/settings/settings_screen.dart';
import 'package:warehouse_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = ThemeMode.system == ThemeMode.light ? false : true;
  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.setData(key: 'isDark', value: isDark).then(
        (value) {
          emit(AppChangeModeState());
        },
      );
    }
  }

  final List<Widget> screens = const [
    QrScreen(),
    ItemsScreen(),
    MyItemsScreen(),
    SettingsScreen(),
  ];

  final List<String> titles = const [
    "Home",
    "Browse items",
    "My items",
    "Settings"
  ];
  int currentBottomNavIndex = 0;
  void changBottomNavIndex(int index) {
    currentBottomNavIndex = index;
    emit(AppChangeBottomNavState());
  }
}
