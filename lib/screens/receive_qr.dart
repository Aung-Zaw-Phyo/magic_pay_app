import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveQrScreen extends StatelessWidget {
  const ReceiveQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receive QR'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'QR Scan to pay me',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 26,
                        ),
                  ),
                  const SizedBox(height: 20),
                  QrImageView(
                    data: '09968548024',
                    version: QrVersions.auto,
                    size: 240,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Aung Zaw Phyo',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '09968548024',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
