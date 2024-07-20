import 'package:equatable/equatable.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class GetNotifications extends NotificationsEvent {
  final int page;
  const GetNotifications(this.page);

  @override
  List<Object> get props => [page];
}

class NotificationsRefresh extends NotificationsEvent {
  const NotificationsRefresh();

  @override
  List<Object> get props => [];
}
