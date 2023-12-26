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

  void createCheckOut({
    required int itemId,
    required int employeeId,
    required String estimatedCheckInDate,
    required String? jobAssigned,
    required String? companyLended,
  }) {
    emit(ItemCheckoutLoadingState());
    DioHelper.postData(url: check_outs, data: {
      "item_id": itemId,
      "employee_id": employeeId,
      "estimated_Check_in_Date": estimatedCheckInDate,
      "check_out_date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "check_out_time": DateFormat('HH:mm:ss').format(DateTime.now()),
      "job_assigned": jobAssigned,
      "company_lended": companyLended,
    }).then((value) {
      emit(ItemCheckoutSuccessState(message: value.data));
    }).catchError((error) {
      emit(ItemCheckoutErrorState(message: error));
    });


  }
}
