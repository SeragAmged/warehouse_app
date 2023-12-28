import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/layout/cubit/cubit.dart';
import 'package:warehouse_app/layout/cubit/states.dart';
import 'package:warehouse_app/modules/items/item_widget.dart';
import 'package:warehouse_app/shared/network/remote/end_points.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getItems(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return ConditionalBuilder(
            condition: State is AppGetDataLoadingState,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
            fallback: (context) => ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: cubit.itemModel.length,
              itemBuilder: (context, index) => ItemWidget(
                seId: cubit.itemModel[index].seId ?? 0,
                image: cubit.itemModel[index].detail?.imageLink ?? defaultImage,
                name: cubit.itemModel[index].detail?.name ?? "NO NAME",
                statue: cubit.itemModel[index].status ?? "UNKNOWN STATUS",
                detail:
                    cubit.itemModel[index].detail?.details ?? "UNKNOWN DETAIL",
                sheet: cubit.itemModel[index].detail?.dataSheetLink ??
                    "NO dataSheetLink",
              ),
            ),
          );
        },
      ),
    );
  }
}
