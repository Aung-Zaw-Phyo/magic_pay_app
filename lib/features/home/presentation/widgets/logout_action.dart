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

class LogoutAction extends StatelessWidget {
  const LogoutAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AuthActionBloc>(),
      child: Builder(builder: (context) {
        return Column(
          children: [
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
        );
      }),
    );
  }
}
