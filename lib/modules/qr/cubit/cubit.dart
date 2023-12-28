import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/models/item_model.dart';
import 'package:warehouse_app/modules/qr/cubit/states.dart';
import 'package:warehouse_app/shared/network/remote/dio_helper.dart';
import 'package:warehouse_app/shared/network/remote/end_points.dart';

class ItemByIdCubit extends Cubit<ItemByIdStates> {
  ItemByIdCubit() : super(ItemByIdInitialState());

  static ItemByIdCubit get(context) => BlocProvider.of(context);

  ItemModel? itemModel;
  void getItemBySeID({required int seId}) {
    emit(ItemByIdGetLoadingState());
    DioHelper.getData(url: "$items/$seId").then((value) {
      itemModel = ItemModel.fromJson(value.data);
      emit(ItemByIdGetItemSuccessState());
    }).catchError((error) {
      emit(ItemByIdGetItemErrorState(message: error));
    });
  }
}
