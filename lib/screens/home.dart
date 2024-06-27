import 'package:flutter/material.dart';
import 'package:magic_pay_app/screens/notification.dart';
import 'package:magic_pay_app/screens/receive_qr.dart';
import 'package:magic_pay_app/screens/scan.dart';
import 'package:magic_pay_app/screens/transaction.dart';
import 'package:magic_pay_app/screens/transfer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://lh3.googleusercontent.com/a/ACg8ocLPWwKFLPSK4kUh5C1J_-p3BM3SRQ3y7OcmFa9UwQe2DyctPBU=s360-c-no'),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Aung Zaw Phyo',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              '30,000 MMK',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Card(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ScanScreen(),
                            ),
                          );
                        },
                        leading: const Icon(Icons.qr_code_scanner_rounded),
                        title: const Text('Scan & Pay'),
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ReceiveQrScreen(),
                            ),
                          );
                        },
                        leading: const Icon(Icons.qr_code),
                        title: const Text('Receive QR'),
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TransferScreen(),
                        ),
                      );
                    },
                    leading: const Icon(Icons.send_to_mobile),
                    title: const Text('Transfer'),
                    trailing: const Icon(
                      Icons.navigate_next_rounded,
                      size: 30,
                    ),
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: const Color.fromARGB(48, 0, 0, 0),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TransactionScreen(),
                        ),
                      );
                    },
                    leading: const Icon(Icons.receipt_long),
                    title: const Text('Transaction'),
                    trailing: const Icon(
                      Icons.navigate_next_rounded,
                      size: 30,
                    ),
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: const Color.fromARGB(48, 0, 0, 0),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                    leading: const Icon(Icons.notification_important_sharp),
                    title: const Text('Notification'),
                    trailing: const Icon(
                      Icons.navigate_next_rounded,
                      size: 30,
                    ),
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
