import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:warehouse_app/modules/item/cubit/states.dart';
import 'package:warehouse_app/shared/network/remote/dio_helper.dart';
import 'package:warehouse_app/shared/network/remote/end_points.dart';

class ItemCubit extends Cubit<ItemStates> {
  ItemCubit() : super(ItemInitialState());

  static ItemCubit get(context) => BlocProvider.of(context);

  // final List<Widget> screens = const [
  //   QrScreen(),
  //   ItemsScreen(),
  //   MyItemsScreen(),
  //   SettingsScreen(),
  // ];

  // final List<String> titles = const [
  //   "Home",
  //   "Browse items",
  //   "My items",
  //   "Settings"
  // ];
  int currentNavIndex = 0;
  void changBottomNavIndex(int index) {
    currentNavIndex = index;
    emit(ItemChangeNavState());
  }

  /*
  {
  "item_id": 0,
  "employee_id": 0,
  "work_order": 0,
  "jop_name": "string",
  "company_lended": "string",
  "estimated_Check_in_Date": "2023-12-28",
  "date": "2023-12-27",
  "time": "22:36:18.872507"
} 
   */

  void createCheckOut({
    required int seId,
    required int sesaId,
    required String estimatedCheckInDate,
    required String? jobName,
    required int? workOrder,
    required String? companyLended,
  }) {
    emit(ItemCheckoutLoadingState());
    DioHelper.postData(
      url: "items/check_out/$seId",
      data: {
        "item_id": 0,
        "employee_id": 0,
        "work_order": workOrder,
        "jop_name": jobName,
        "company_lended": companyLended,
        "estimated_Check_in_Date": estimatedCheckInDate,
        "date": "2023-12-27",
        "time": "22:36:18.872507",
      },
      query: {"employee_sesa_id": sesaId},

    ).then((value) {
      emit(ItemCheckoutSuccessState());
    }).catchError((error) {
      emit(ItemCheckoutErrorState(message: error));
    });
  }
}
