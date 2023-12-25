import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:warehouse_app/models/item_model.dart';
import 'package:warehouse_app/modules/item/item_screen.dart';
import 'package:warehouse_app/modules/qr/cubit/cubit.dart';
import 'package:warehouse_app/modules/qr/cubit/states.dart';
import 'package:warehouse_app/shared/components/functions.dart';
import 'package:warehouse_app/shared/network/remote/dio_helper.dart';
import 'package:warehouse_app/shared/network/remote/end_points.dart';

import '../../shared/components/components.dart';

// class QrScreen extends StatefulWidget {
//   const QrScreen({super.key});

//   @override
//   State<QrScreen> createState() => _QrScreenState();
// }

class QrScreen extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();

  Code? result;
  Codes? multiResult;

  bool isMultiScan = false;
  bool showDebugInfo = false;
  int successScans = 0;
  int failedScans = 0;

  QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const isCameraSupported = true;
    return BlocConsumer<ItemByIdCubit, ItemByIdStates>(
      listener: (context, state) {
        ItemModel? itemModel = ItemByIdCubit.get(context).itemModel;
        if (state is ItemByIdGetItemSuccessState) {
          navigateTo(
            context,
            ItemScreen(
              name: itemModel?.tool?.toolName ?? " hamo",
              statue: itemModel?.status ?? "available",
              image: 
                  "https://media.megger.com/mediacontainer/medialibraries/meggerglobal/product-images/mit510-2/image_1-small-auto-sized.jpg",
              details: itemModel?.tool?.details ?? "no details available",
              sheet: itemModel?.tool?.dataSheetPdfLink ?? "no pdf link",
              id: itemModel?.itemId ?? 1,
            ),
          );
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 1,
          child: Scaffold(
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Stack(
                  children: [
                    ReaderWidget(
                      onScan: (Code? code) {
                        successScans++;
                        result = code;

                        ItemByIdCubit.get(context).getItemByID(
                            id: int.parse(code?.text?.toString() ?? '1'));

                        _showMessage(context, result!.text.toString());
                      },
                      // onScanFailure: _onScanFailure,
                      scanDelay: Duration(milliseconds: isMultiScan ? 50 : 500),
                      resolution: ResolutionPreset.high,
                      lensDirection: CameraLensDirection.back,
                      showToggleCamera: false,
                      showGallery: false,
                      showFlashlight: false,
                    ),
                    Positioned.fill(
                      bottom: -350,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          // height: 50,
                          width: 250,
                          child: defaultTextFormField(
                            controller: _codeController,
                            type: TextInputType.text,
                            hint: "Enter Code...",
                            // prefix: Icons.qr_code_rounded,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // _onScanSuccess(Code? code) {
  //   setState(() {
  //     successScans++;
  //     result = code;

  //     ItemModel? itemModel;
  //     void getItemByID({required int id}) {
  //       // emit(ItemByIdGetLoadingState());
  //       DioHelper.getData(url: "$items/$id").then((value) {
  //         itemModel = ItemModel.fromJson(value.data);
  //         // emit(ItemByIdGetItemSuccessState());
  //       }).catchError((error) {
  //         // emit(ItemByIdGetItemErrorState(message: error));
  //       });
  //     }

  //     getItemByID(id: int.parse(code?.text?.toString() ?? '1'));
  //     print("object");
  //     if (itemModel != null) {
  //       navigateTo(
  //         context,
  //         ItemScreen(
  //           name: itemModel?.tool?.toolName ?? " hamo",
  //           statue: itemModel?.status ?? "available",
  //           image: itemModel?.tool?.imageLink ?? "",
  //           details: itemModel?.tool?.details ?? "no details available",
  //           sheet: itemModel?.tool?.dataSheetPdfLink ?? "no pdf link",
  //           id: itemModel?.itemId ?? 1,
  //         ),
  //       );
  //     }

  //     _showMessage(context, result!.text.toString());
  //   });
  // }

  // _onScanFailure(Code? code) {
  //   setState(() {
  //     failedScans++;
  //     result = code;
  //   });
  //   if (code?.error?.isNotEmpty == true) {
  //     _showMessage(context, 'Error: ${code?.error}');
  //   }
  // }

  _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
} 

/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:warehouse_app/modules/item/item_screen.dart';
import 'package:warehouse_app/modules/qr/cubit/cubit.dart';
import 'package:warehouse_app/modules/qr/cubit/states.dart';
import 'package:warehouse_app/shared/components/functions.dart';

import '../../shared/components/components.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final TextEditingController _codeController = TextEditingController();

  Code? result;
  Codes? multiResult;

  bool isMultiScan = false;
  bool showDebugInfo = false;
  int successScans = 0;
  int failedScans = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ItemByIdCubit(),
      child: BlocConsumer<ItemByIdCubit, ItemByIdStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ItemByIdCubit cubit = ItemByIdCubit.get(context);
          return DefaultTabController(
            length: 1,
            child: Scaffold(
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Stack(
                    children: [
                      ReaderWidget(
                        onScan: (Code? code) {
                          setState(() {
                            successScans++;
                            result = code;
                            cubit.getItemByID(
                                id: int.parse(result!.text.toString()));
                            navigateTo(
                              context,
                              ItemScreen(
                                name:
                                    cubit.itemModel?.tool?.toolName ?? " hamo",
                                statue: cubit.itemModel?.status ?? "available",
                                image: cubit.itemModel?.tool?.imageLink ?? "",
                                details: cubit.itemModel?.tool?.details ??
                                    "no details available",
                                sheet:
                                    cubit.itemModel?.tool?.dataSheetPdfLink ??
                                        "no pdf link",
                                id: cubit.itemModel?.itemId ?? 1,
                              ),
                            );
                            _showMessage(context, result!.text.toString());
                          });
                        },
                        onScanFailure: _onScanFailure,
                        scanDelay:
                            Duration(milliseconds: isMultiScan ? 50 : 500),
                        resolution: ResolutionPreset.high,
                        lensDirection: CameraLensDirection.back,
                        showToggleCamera: false,
                        showGallery: false,
                        showFlashlight: false,
                      ),
                      Positioned.fill(
                        bottom: -350,
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            // height: 50,
                            width: 250,
                            child: defaultTextFormField(
                              controller: _codeController,
                              type: TextInputType.text,
                              hint: "Enter Code...",
                              onFieldSubmitted: (p0) {
                                cubit.getItemByID(
                                    id: int.parse(result!.text.toString()));
                                navigateTo(
                                  context,
                                  ItemScreen(
                                      name: cubit.itemModel?.tool?.toolName ??
                                          " hamo",
                                      statue: cubit.itemModel?.status ??
                                          "available",
                                      image: cubit.itemModel?.tool?.imageLink ??
                                          "",
                                      details: cubit.itemModel?.tool?.details ??
                                          "no details available",
                                      sheet: cubit.itemModel?.tool
                                              ?.dataSheetPdfLink ??
                                          "no pdf link",
                                      id: cubit.itemModel?.itemId ?? 1),
                                );
                              },
                              // prefix: Icons.qr_code_rounded,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onScanFailure(Code? code) {
    setState(() {
      failedScans++;
      result = code;
    });
    if (code?.error?.isNotEmpty == true) {
      _showMessage(context, 'Error: ${code?.error}');
    }
  }

  _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
 */