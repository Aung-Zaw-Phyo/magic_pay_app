import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_state.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveQrScreen extends StatelessWidget {
  const ReceiveQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receive QR'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
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
            return Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'QR Scan to pay me',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 26,
                                  ),
                        ),
                        const SizedBox(height: 20),
                        QrImageView(
                          key: const Key('generated_qr_image'),
                          data: state.profileEntity.phone,
                          version: QrVersions.auto,
                          size: 240,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          state.profileEntity.name,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          state.profileEntity.phone,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(),
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
