import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_data.dart';

class NotificationsState extends Equatable {
  final NotificationDataEntity? notificationData;
  final String? error;

  const NotificationsState({this.notificationData, this.error});

  @override
  List<Object?> get props => [notificationData, error];
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading();
}

class NotificationsLoaded extends NotificationsState {
  const NotificationsLoaded(NotificationDataEntity data)
      : super(notificationData: data);
}

class NotificationsLoadFailed extends NotificationsState {
  const NotificationsLoadFailed(String error) : super(error: error);
}
