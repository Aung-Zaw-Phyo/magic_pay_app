import 'package:magic_pay_app/features/notification/domain/entities/notification_detail.dart';

class DeepLinkModel extends DeepLink {
  const DeepLinkModel({String? target, String? parameter})
      : super(
          target: target,
          parameter: parameter,
        );

  factory DeepLinkModel.fromJson(Map<String, dynamic> json) {
    return DeepLinkModel(
      target: json['target'],
      parameter: json['parameter'],
    );
  }
}

class NotificationDetailModel extends NotificationDetailEntity {
  const NotificationDetailModel({
    required String title,
    required String message,
    required String dateTime,
    required DeepLinkModel deepLink,
  }) : super(
          title: title,
          message: message,
          dateTime: dateTime,
          deepLink: deepLink,
        );

  factory NotificationDetailModel.fromJson(Map<String, dynamic> json) =>
      NotificationDetailModel(
        title: json['title'],
        message: json['message'],
        dateTime: json['date_time'],
        deepLink:
            DeepLinkModel.fromJson(json['deep_link'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "date_time": dateTime,
        "deep_link": {
          "target": deepLink.target,
          "parameter": deepLink.parameter,
        },
      };
}
