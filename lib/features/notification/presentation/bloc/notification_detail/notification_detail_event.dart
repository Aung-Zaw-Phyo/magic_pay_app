import 'package:equatable/equatable.dart';

class NotificationDetailEvent extends Equatable {
  const NotificationDetailEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationDetail extends NotificationDetailEvent {
  final String notificationId;
  const GetNotificationDetail(this.notificationId);

  @override
  List<Object> get props => [];
}
