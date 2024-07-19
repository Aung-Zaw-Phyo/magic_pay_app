import 'package:equatable/equatable.dart';

class DeepLink extends Equatable {
  final String? target;
  final String? parameter;
  const DeepLink({this.target, this.parameter});

  @override
  List<Object?> get props => [target, parameter];
}

class NotificationDetailEntity extends Equatable {
  final String title;
  final String message;
  final String dateTime;
  final DeepLink deepLink;

  const NotificationDetailEntity({
    required this.title,
    required this.message,
    required this.dateTime,
    required this.deepLink,
  });

  @override
  List<Object> get props => [title, message, dateTime, deepLink];
}
