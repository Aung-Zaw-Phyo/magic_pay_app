import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_state.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_state.dart';

class PayFormScreen extends StatefulWidget {
  const PayFormScreen({super.key});

  @override
  State<PayFormScreen> createState() => _PayFormScreenState();
}

class _PayFormScreenState extends State<PayFormScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredAmount = 0;
  var _enteredDescription = '';
  bool isSubmit = false;

  void onSubmit(String toPhone) {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      String message = '$toPhone$_enteredAmount$_enteredDescription';
      Hmac hmac = Hmac(sha256, utf8.encode(secretKey));
      Digest hashValue = hmac.convert(utf8.encode(message));

      BlocProvider.of<PayConfirmBloc>(context).add(
        PayConfirm(
          ScanPayRequestEntity(
            toPhone: toPhone,
            amount: _enteredAmount,
            hashValue: hashValue.toString(),
            description: _enteredDescription,
          ),
        ),
      );
      isSubmit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay'),
      ),
      body: BlocBuilder<ScanQrCodeBloc, ScanQrCodeState>(
        builder: (context, state) {
          if (state is ScanQrCodeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ScanQrCodeLoadFailed) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              error(context, state.message);
            });
          }

          if (state is ScanQrCodeLoaded) {
            final formData = state.scanPayFormDataEntity;
            return Container(
              padding: const EdgeInsets.all(14),
              child: SingleChildScrollView(
                child: Card(
                  color: Colors.white,
                  child: Form(
                    key: _form,
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
                            formData.fromName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            formData.fromPhone,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'To',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formData.toName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            formData.toPhone,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(),
                          ),
                          TextFormField(
                            key: const Key('amount_field'),
                            decoration: const InputDecoration(
                              labelText: 'Amount (MMK)',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter a valid amount.";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredAmount = int.parse(newValue!);
                            },
                          ),
                          TextFormField(
                            key: const Key('description_field'),
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
                            validator: (value) {
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredDescription = newValue ?? '';
                            },
                          ),
                          const SizedBox(height: 22),
                          BlocBuilder<PayConfirmBloc, PayConfirmState>(
                            builder: (context, state) {
                              if (state is PayConfirmLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (state is PayConfirmLoadFailed) {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  error(context, state.message);
                                });
                              }

                              if (state is PayConfirmLoaded &&
                                  isSubmit == true) {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.pushNamed(context, '/pay_confirm');
                                });
                              }

                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    onSubmit(formData.toPhone);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Text(
                                    'Continue',
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
                              );
                            },
                          ),
                        ],
                      ),
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
