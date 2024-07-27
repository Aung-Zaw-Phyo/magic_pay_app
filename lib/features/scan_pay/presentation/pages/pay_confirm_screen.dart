import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_data.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_state.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_complete/transfer_complete_bloc.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_complete/transfer_complete_event.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_complete/transfer_complete_state.dart';

class PayConfirmScreen extends StatefulWidget {
  const PayConfirmScreen({super.key});

  @override
  State<PayConfirmScreen> createState() => _PayConfirmScreenState();
}

class _PayConfirmScreenState extends State<PayConfirmScreen> {
  bool isSubmit = false;
  final _passwordController = TextEditingController();

  void _showConfirmDialog(ScanPayDataEntity scanPayDataEntity) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Please enter your password.'),
          content: TextField(
            decoration: const InputDecoration(hintText: 'Enter password'),
            obscureText: true,
            controller: _passwordController,
          ),
          actions: [
            BlocBuilder<TransferCompleteBloc, TransferCompleteState>(
              builder: (context, state) {
                if (state is TransferCompleteLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TransferCompleteLoadFailed) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    error(context, state.message);
                  });
                }

                if (state is TransferCompleteLoaded && isSubmit == true) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushNamed(
                      '/transaction_detail',
                      arguments: state.trxId,
                    );
                  });
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: () {
                        final password = _passwordController.text;
                        if (password.trim().length < 6) {
                          error(context, 'Please enter your correct password.');
                          return;
                        }
                        BlocProvider.of<TransferCompleteBloc>(context).add(
                          TransferComplete(
                            TransferRequestEntity(
                              toPhone: scanPayDataEntity.toPhone,
                              amount: scanPayDataEntity.amount,
                              hashValue: scanPayDataEntity.hashValue,
                              description: scanPayDataEntity.description,
                              password: password,
                            ),
                          ),
                        );
                        isSubmit = true;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm'),
      ),
      body: BlocBuilder<PayConfirmBloc, PayConfirmState>(
        builder: (context, state) {
          if (state is PayConfirmLoaded) {
            final payData = state.scanPayDataEntity;
            return Container(
              padding: const EdgeInsets.all(14),
              child: SingleChildScrollView(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          payData.fromName,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          payData.fromPhone,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'From',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          payData.toName,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          payData.toPhone,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Amount (MMK)',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${payData.amount}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Description',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          payData.description ?? '',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _showConfirmDialog(state.scanPayDataEntity);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              'Confirm',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
