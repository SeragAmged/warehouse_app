import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/layout/cubit/cubit.dart';
import 'package:warehouse_app/layout/cubit/states.dart';
import 'package:warehouse_app/modules/items/item_widget.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return ConditionalBuilder(
          condition: false /* State is AppGetDataLoadingState */,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
          fallback: (context) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 10 /* cubit.itemModel!.length */,
            itemBuilder: (context, index) => const ItemWidget(
              id: 1 /* cubit.itemModel![index].itemId! */,
              image:
                  "https://media.megger.com/mediacontainer/medialibraries/meggerglobal/product-images/mit510-2/image_1-small-auto-sized.jpg",
              name: "name"/*  cubit.itemModel![index].tool!.toolName! */,
              statue: "statues"/* cubit.itemModel![index].status ?? "null" */,
              detail: "detaiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiilsdetaiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiilsdetaiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiils"/* cubit.itemModel![index].tool!.details ?? "null" */,
              sheet: "PDF.com"/* cubit.itemModel![index].status ?? "null" */,
            ),
          ),
        );
      },
    );
  }
}
