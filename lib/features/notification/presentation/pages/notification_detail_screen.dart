import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_bloc.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_event.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_state.dart';

class NotificationDetailScreen extends StatefulWidget {
  final String notificationId;
  const NotificationDetailScreen({super.key, required this.notificationId});

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<NotificationDetailBloc>(context)
        .add(GetNotificationDetail(widget.notificationId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Detail'),
      ),
      body: BlocBuilder<NotificationDetailBloc, NotificationDetailState>(
        builder: (context, state) {
          if (state is NotificationDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is NotificationDetailLoadFailed) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is NotificationDetailLoaded) {
            final notification = state.notification;
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/notification.png'),
                        width: 300,
                      ),
                      Text(
                        notification.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 22,
                            ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        notification.message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.dateTime,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 140,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
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
