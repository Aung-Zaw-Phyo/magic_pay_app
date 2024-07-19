import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_data.dart';
import 'package:magic_pay_app/features/notification/domain/usecases/get_notifications.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockNotificationRepository mockNotificationRepository;
  late GetNotificationsUseCase getNotificationsUseCase;

  setUp(() {
    mockNotificationRepository = MockNotificationRepository();
    getNotificationsUseCase =
        GetNotificationsUseCase(mockNotificationRepository);
  });

  const testNotifications = [
    NotificationEntity(
      id: '123',
      title: "Password Updated",
      message: "Your password updated successfully!",
      dateTime: "2024-07-09 02:07:40 PM",
      read: 0,
    ),
    NotificationEntity(
      id: '456',
      title: "Password Updated",
      message: "Your password updated successfully!",
      dateTime: "2024-07-09 02:07:40 PM",
      read: 0,
    ),
  ];

  const testNotificationDataEntity = NotificationDataEntity(
    currentPage: 1,
    lastPage: 2,
    notifications: testNotifications,
  );

  group('get notifications', () {
    test(
      'should get notifications data from the repository when success',
      () async {
        when(mockNotificationRepository.getNotifications(1))
            .thenAnswer((_) async => const Right(testNotificationDataEntity));

        final result = await getNotificationsUseCase.execute(1);

        expect(result, const Right(testNotificationDataEntity));
      },
    );

    test(
      'should get server error from the repository when does not success.',
      () async {
        when(mockNotificationRepository.getNotifications(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failed!')));

        final result = await getNotificationsUseCase.execute(1);

        expect(result, const Left(ServerFailure('Server Failed!')));
      },
    );
  });
}
