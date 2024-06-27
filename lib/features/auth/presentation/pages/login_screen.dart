import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_bloc.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_event.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_state.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/status/auth_status_bloc.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/status/auth_status_event.dart';
import 'package:magic_pay_app/injection_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredPhone = '';
  var _enteredPassword = '';

  // void _submit() {
  //   final isValid = _form.currentState!.validate();
  //   if (isValid) {
  //     _form.currentState!.save();
  //     BlocProvider.of<AuthActionBloc>(context).add(
  //       AuthLogin(
  //         phone: _enteredPhone,
  //         password: _enteredPassword,
  //       ),
  //     );
  //   }
  // }

  void _register() async {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthActionBloc>(
      create: (context) => locator<AuthActionBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _form,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(),
                        ),
                        const SizedBox(height: 6),
                        const Text('Fill the form to login'),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Phone'),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().length < 5) {
                              return "Please enter a valid phone number.";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _enteredPhone = newValue!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Password'),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return "Please enter a valid password.";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _enteredPassword = newValue!;
                          },
                        ),
                        const SizedBox(height: 18),
                        BlocBuilder<AuthActionBloc, AuthActionState>(
                            builder: (context, state) {
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator();
                          }
                          if (state is AuthLoadFailed) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              error(context, state.message);
                            });
                          }
                          if (state is AuthLoaded) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              success(context, state.result.message);
                              BlocProvider.of<AuthStatusBloc>(context)
                                  .add(const CheckAuthStatus());
                            });
                          }

                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                final isValid = _form.currentState!.validate();
                                if (isValid) {
                                  _form.currentState!.save();
                                  BlocProvider.of<AuthActionBloc>(context).add(
                                    AuthLogin(
                                      phone: _enteredPhone,
                                      password: _enteredPassword,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      fontSize: 20,
                                    ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: _register,
                            child: Text(
                              'Register',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
