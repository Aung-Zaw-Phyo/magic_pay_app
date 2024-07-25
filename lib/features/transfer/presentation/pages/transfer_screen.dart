import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_bloc.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_event.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_state.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredToPhone = '';
  var _enteredAmount = 0;
  var _enteredDescription = '';
  bool isSubmit = false;

  void onSubmit() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      String message = '$_enteredToPhone$_enteredAmount$_enteredDescription';
      Hmac hmac = Hmac(sha256, utf8.encode(secretKey));
      Digest hashValue = hmac.convert(utf8.encode(message));
      BlocProvider.of<TransferConfirmBloc>(context).add(
        TransferConfirm(
          TransferRequestEntity(
            toPhone: _enteredToPhone,
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
        title: const Text('Transfer'),
      ),
      body: Container(
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
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Aung Zaw Phyo',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '09968548024',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      key: const Key('to_phone_field'),
                      decoration: const InputDecoration(
                        labelText: 'To',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().length < 5) {
                          return "Please enter a valid phone number.";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredToPhone = newValue!;
                      },
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
                    BlocBuilder<TransferConfirmBloc, TransferConfirmState>(
                      builder: (context, state) {
                        if (state is TransferConfirmLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is TransferConfirmLoadFailed) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            error(context, state.message);
                          });
                        }

                        if (state is TransferConfirmLoaded &&
                            isSubmit == true) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushNamed(context, '/transfer_confirm');
                          });
                        }

                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                          ),
                          child: ElevatedButton(
                            onPressed: onSubmit,
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
      ),
    );
  }
}
