import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_data_model.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_model.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_data.dart';

void main() {
  const testNotifications = [
    NotificationModel(
      id: '123',
      title: "Password Updated",
      message: "Your password updated successfully!",
      dateTime: "2024-07-09 02:07:40 PM",
      read: 0,
    ),
    NotificationModel(
      id: '456',
      title: "Password Updated",
      message: "Your password updated successfully!",
      dateTime: "2024-07-09 02:07:40 PM",
      read: 0,
    ),
  ];

  const testNotificationDataModel = NotificationDataModel(
    currentPage: 1,
    lastPage: 2,
    notifications: testNotifications,
  );

  test(
    'should be a sub class of notification data entity',
    () {
      expect(testNotificationDataModel, isA<NotificationDataEntity>());
    },
  );
}
