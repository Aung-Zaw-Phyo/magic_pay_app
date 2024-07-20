import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_state.dart';
import 'package:magic_pay_app/features/notification/presentation/pages/notification_screen.dart';
import 'package:magic_pay_app/screens/receive_qr.dart';
import 'package:magic_pay_app/screens/scan.dart';
import 'package:magic_pay_app/screens/transaction.dart';
import 'package:magic_pay_app/screens/transfer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is ProfileLoadFailed) {
        return Center(
          child: Text(state.message),
        );
      }

      if (state is ProfileLoaded) {
        return Center(
          key: const Key('profile_data'),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(state.profileEntity.profile),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  state.profileEntity.name,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${state.profileEntity.balance} MMK',
                  style: const TextStyle(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
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

      return Container();
    });
  }
}
