import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/modules/item/cubit/states.dart';

class ItemCubit extends Cubit<ItemStates> {
  ItemCubit() : super(AppInitialState());

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
    emit(AppChangeNavState());
  }
}
