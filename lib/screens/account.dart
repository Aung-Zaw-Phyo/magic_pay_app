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

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthActionBloc>(
      create: (context) => locator<AuthActionBloc>(),
      child: Builder(builder: (context) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Username',
                        style:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(),
                      ),
                      const Spacer(),
                      Text(
                        'Aung Zaw Phyo',
                        style:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 13),
                    color: const Color.fromARGB(48, 0, 0, 0),
                  ),
                  Row(
                    children: [
                      Text(
                        'Email',
                        style:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(),
                      ),
                      const Spacer(),
                      Text(
                        'aungzawphyo1102@gmail.com',
                        style:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 13),
                    color: const Color.fromARGB(48, 0, 0, 0),
                  ),
                  Row(
                    children: [
                      Text(
                        'Phone',
                        style:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(),
                      ),
                      const Spacer(),
                      Text(
                        '09968548024',
                        style:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.password),
                    title: const Text('Update Password'),
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
                  BlocBuilder<AuthActionBloc, AuthActionState>(
                      builder: ((context, state) {
                    if (state is AuthLoadFailed) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        error(context, state.message);
                      });
                    }
                    if (state is AuthLoaded) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        BlocProvider.of<AuthStatusBloc>(context)
                            .add(const CheckAuthStatus());
                      });
                    }
                    return const SizedBox();
                  })),
                  ListTile(
                    onTap: () {
                      BlocProvider.of<AuthActionBloc>(context)
                          .add(const AuthLogout());
                    },
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
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
        );
      }),
    );
  }
}
