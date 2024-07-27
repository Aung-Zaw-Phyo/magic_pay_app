import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() {
    return _ScanQrScreenState();
  }
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  var _isScanning = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        BlocProvider.of<ScanQrCodeBloc>(context)
            .add(ScanQrCode(scanData as String));
        _isScanning = false;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Column(
        children: [
          if (!_isScanning)
            Container(
              color: Theme.of(context).colorScheme.primary,
              width: double.infinity,
              height: 420,
              child: BlocBuilder<ScanQrCodeBloc, ScanQrCodeState>(
                  builder: (context, state) {
                if (state is ScanQrCodeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.white),
                  );
                }

                if (state is ScanQrCodeLoadFailed) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    error(context, state.message);
                  });
                }

                if (state is ScanQrCodeLoaded && result != null) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(context, '/pay_form');
                  });
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner,
                      size: 240,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Click button, put QR code in the frame and pay',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ],
                );
              }),
            ),
          if (_isScanning)
            Container(
              width: double.infinity,
              height: 420,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          const SizedBox(height: 30),
          Container(
            width: 180,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                // setState(() {
                //   _isScanning = !_isScanning;
                // });
                const test = '09968548025';
                BlocProvider.of<ScanQrCodeBloc>(context).add(ScanQrCode(test));
              },
              icon: Icon(
                Icons.qr_code_scanner_rounded,
                color: Theme.of(context).colorScheme.background,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              label: Text(
                _isScanning ? 'Scanning' : 'Scan',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
