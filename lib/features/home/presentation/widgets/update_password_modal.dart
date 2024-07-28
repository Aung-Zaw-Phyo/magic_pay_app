import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/update_password/update_password_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/update_password/update_password_event.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/update_password/update_password_state.dart';

class UpdatePasswordModal extends StatefulWidget {
  const UpdatePasswordModal({super.key});

  @override
  State<UpdatePasswordModal> createState() => _UpdatePasswordModalState();
}

class _UpdatePasswordModalState extends State<UpdatePasswordModal> {
  final _form = GlobalKey<FormState>();
  var _enteredOldPassword = '';
  var _enteredNewPassword = '';
  bool isSubmit = false;

  void _submit() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      isSubmit = true;
      BlocProvider.of<UpdatePasswordBloc>(context).add(
        UpdatePassword(
          oldPassword: _enteredOldPassword,
          newPassword: _enteredNewPassword,
        ),
      );
    }
  }

  void _showMessage(String message) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Okay'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('oldPassword_field'),
                    decoration: const InputDecoration(
                      label: Text('Old Password'),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return "Please enter a valid password.";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredOldPassword = newValue!;
                    },
                  ),
                  TextFormField(
                    key: const Key('newPassword_field'),
                    decoration: const InputDecoration(
                      label: Text('New Password'),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return "Please enter a valid password.";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredNewPassword = newValue!;
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 12),
                      BlocBuilder<UpdatePasswordBloc, UpdatePasswordState>(
                        builder: (context, state) {
                          if (state is UpdatePasswordLoadFailed && isSubmit) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              isSubmit = false;
                              _showMessage(state.message);
                            });
                          }
                          if (state is UpdatePasswordLoaded && isSubmit) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              isSubmit = false;
                              _showMessage('Password updated successfully.');
                              _form.currentState!.reset();
                            });
                          }
                          return ElevatedButton(
                            onPressed: state is UpdatePasswordLoading
                                ? () {}
                                : _submit,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 14,
                              ),
                            ),
                            child: state is UpdatePasswordLoading
                                ? const Text('Loading ...')
                                : const Text('Save Password'),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
