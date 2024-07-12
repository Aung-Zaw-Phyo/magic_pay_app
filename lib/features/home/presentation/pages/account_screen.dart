import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_state.dart';
import 'package:magic_pay_app/features/home/presentation/widgets/logout_action.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
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
          return Column(
            key: const Key('account_data'),
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
                    const LogoutAction(),
                  ],
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
