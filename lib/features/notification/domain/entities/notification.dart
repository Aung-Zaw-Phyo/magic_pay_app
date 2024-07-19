import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String message;
  final String dateTime;
  final int read;
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.dateTime,
    required this.read,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      NotificationEntity(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        dateTime: json["date_time"],
        read: json["read"],
      );

  @override
  List<Object> get props => [id, title, message, dateTime, read];
}
