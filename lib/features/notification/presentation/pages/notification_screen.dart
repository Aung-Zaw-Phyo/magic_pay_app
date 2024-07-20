import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_event.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    final notiBloc = BlocProvider.of<NotificationsBloc>(context);
    if (notiBloc.state.notificationData == null) {
      notiBloc.add(const GetNotifications(1));
    }

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        final data = notiBloc.state.notificationData;
        if (data != null && data.currentPage < data.lastPage) {
          notiBloc.add(GetNotifications(data.currentPage + 1));
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future refresh() async {
    BlocProvider.of<NotificationsBloc>(context)
        .add(const NotificationsRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is NotificationsLoadFailed) {
            return Center(
              child: Text(state.error!),
            );
          }

          if (state is NotificationsLoaded) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount:
                          state.notificationData!.notifications.length + 1,
                      itemBuilder: (context, index) {
                        if (index <
                            state.notificationData!.notifications.length) {
                          final notification =
                              state.notificationData!.notifications[index];
                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.notifications,
                                          color: Color.fromARGB(182, 0, 0, 0),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          notification.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontSize: 17,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      notification.message,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      notification.dateTime,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: const Color.fromARGB(
                                                  201, 0, 0, 0)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          if (state.notificationData!.currentPage ==
                              state.notificationData!.lastPage) {
                            return const SizedBox();
                          }
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
