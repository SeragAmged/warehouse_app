import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

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
    const isCameraSupported = true;
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [

            Stack(
              children: [
                ReaderWidget(
                  onScan: _onScanSuccess,
                  onScanFailure: _onScanFailure,
                  scanDelay: Duration(milliseconds: isMultiScan ? 50 : 500),
                  resolution: ResolutionPreset.high,
                  lensDirection: CameraLensDirection.back,
                  showToggleCamera: false,showGallery: false,showFlashlight: false,

                ),
                Positioned.fill(bottom:-350,child: Align(
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
                ),)
              ],
            ),
          ],
        ),
      ),
    );
  }

  _onScanSuccess(Code? code) {
    setState(() {
      successScans++;
      result = code;
      _showMessage(context, result!.text.toString());
    });
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