import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_detail.dart';

class NotificationDetailState extends Equatable {
  const NotificationDetailState();

  @override
  List<Object> get props => [];
}

class NotificationDetailLoading extends NotificationDetailState {
  const NotificationDetailLoading();
}

class NotificationDetailLoaded extends NotificationDetailState {
  final NotificationDetailEntity notification;
  const NotificationDetailLoaded(this.notification);

  @override
  List<Object> get props => [notification];
}

class NotificationDetailLoadFailed extends NotificationDetailState {
  final String message;
  const NotificationDetailLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
