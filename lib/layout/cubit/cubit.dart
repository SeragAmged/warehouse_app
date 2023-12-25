import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:warehouse_app/layout/cubit/states.dart';
import 'package:warehouse_app/models/item_model.dart';
import 'package:warehouse_app/modules/items/items_screen.dart';
import 'package:warehouse_app/modules/my_items/my_items_screen.dart';
import 'package:warehouse_app/modules/qr/qr_screen.dart';
import 'package:warehouse_app/modules/settings/settings_screen.dart';
import 'package:warehouse_app/shared/network/local/cache_helper.dart';
import 'package:warehouse_app/shared/network/remote/dio_helper.dart';
import 'package:warehouse_app/shared/network/remote/end_points.dart';

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

  final List<Widget> screens =  [
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

  List<ItemModel>? itemModel = [];
  void getItems() {
    emit(AppGetDataLoadingState());
    DioHelper.getData(url: items).then((value) {
      for (int i = 0; i < value.data.length; i++) {
        itemModel?.add(ItemModel.fromJson(value.data[i]));
      }
      emit(AppGetDataSuccessState());
    }).catchError((error) {
      emit(AppGetDataErrorState(error: error));
    });
  }

/*
{
  "item_id": 1,
  "employee_id": 1,
  "estimated_Check_in_Date": "2023-12-20",
  "check_out_date": "2023-12-20",
  "check_out_time": "17:52:46.764Z",
  "job_assigned": "string",
  "company_lended": "string"
}

 */
  
}
