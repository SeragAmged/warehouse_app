import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:warehouse_app/models/item_model.dart';
import 'package:warehouse_app/modules/item/item_screen.dart';
import 'package:warehouse_app/modules/qr/cubit/cubit.dart';
import 'package:warehouse_app/modules/qr/cubit/states.dart';
import 'package:warehouse_app/shared/components/functions.dart';
import 'package:warehouse_app/shared/network/remote/end_points.dart';

import '../../shared/components/components.dart';

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
              name: itemModel?.detail?.name ?? " NO NAME",
              statue: itemModel?.status ?? "UNKNOWN STATUES",
              image: itemModel?.detail?.imageLink ??defaultImage,
              details: itemModel?.detail?.details ?? "no details available",
              sheet: itemModel?.detail?.dataSheetLink ?? "no pdf link",
              seId: itemModel?.seId ?? 1,
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

                        ItemByIdCubit.get(context).getItemBySeID(
                          seId: int.parse(
                            code?.text?.toString() ?? '122',
                          ),
                        );

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
                        child: SizedBox(
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
