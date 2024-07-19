import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_detail_model.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_detail.dart';

void main() {
  const testNotificationDetailModel = NotificationDetailModel(
    title: "Password Updated",
    message: "Your password updated successfully!",
    dateTime: "2024-07-09 02:07:40 PM",
    deepLink: DeepLinkModel(
      target: "profile",
      parameter: null,
    ),
  );

  const jsonMap = {
    "title": "Password Updated",
    "message": "Your password updated successfully!",
    "date_time": "2024-07-09 02:07:40 PM",
    "deep_link": {
      "target": "profile",
      "parameter": null,
    },
  };

  group('notification detail', () {
    test('should be a sub class of notification detail entity', () {
      expect(testNotificationDetailModel, isA<NotificationDetailEntity>());
    });

    test("should return a valid model from json", () {
      // act
      final result = NotificationDetailModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testNotificationDetailModel));
    });

    test("should return a json map containing proper data", () {
      // act
      final result = testNotificationDetailModel.toJson();

      // assert
      expect(result, equals(jsonMap));
    });
  });
}
