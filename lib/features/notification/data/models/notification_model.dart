import 'package:magic_pay_app/features/notification/domain/entities/notification.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required String id,
    required String title,
    required String message,
    required String dateTime,
    required int read,
  }) : super(
          id: id,
          title: title,
          message: message,
          dateTime: dateTime,
          read: read,
        );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'],
        title: json['title'],
        message: json['message'],
        dateTime: json['date_time'],
        read: json['read'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "date_time": dateTime,
        "read": read,
      };
}
