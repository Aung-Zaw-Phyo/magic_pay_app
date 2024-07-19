import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_model.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification.dart';

void main() {
  const testNotificationModel = NotificationModel(
    id: '123',
    title: "Password Updated",
    message: "Your password updated successfully!",
    dateTime: "2024-07-09 02:07:40 PM",
    read: 0,
  );

  const jsonMap = {
    "id": "123",
    "title": "Password Updated",
    "message": "Your password updated successfully!",
    "date_time": "2024-07-09 02:07:40 PM",
    "read": 0,
  };

  group('notification', () {
    test('should be a sub class of notification entity', () {
      expect(testNotificationModel, isA<NotificationEntity>());
    });

    test("should return a valid model from json", () {
      // act
      final result = NotificationModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testNotificationModel));
    });

    test("should return a json map containing proper data", () {
      // act
      final result = testNotificationModel.toJson();

      // assert
      expect(result, equals(jsonMap));
    });
  });
}
