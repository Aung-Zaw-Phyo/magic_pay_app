import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_detail.dart';
import 'package:magic_pay_app/features/notification/domain/usecases/get_notification_detail.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockNotificationRepository mockNotificationRepository;
  late GetNotificationDetailUseCase getNotificationDetailUseCase;

  setUp(() {
    mockNotificationRepository = MockNotificationRepository();
    getNotificationDetailUseCase =
        GetNotificationDetailUseCase(mockNotificationRepository);
  });

  const testNotificationDetailEntity = NotificationDetailEntity(
    title: "Password Updated",
    message: "Your password updated successfully!",
    dateTime: "2024-07-09 02:07:40 PM",
    deepLink: DeepLink(
      target: "profile",
      parameter: null,
    ),
  );

  group('notification detail', () {
    test(
      'should get notification detail data from the repository when success',
      () async {
        when(mockNotificationRepository.getNotificationDetail('123'))
            .thenAnswer((_) async => const Right(testNotificationDetailEntity));

        final result = await getNotificationDetailUseCase.execute('123');

        expect(result, const Right(testNotificationDetailEntity));
      },
    );

    test(
      'should get server error from the repository when does not success.',
      () async {
        when(mockNotificationRepository.getNotificationDetail('123'))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failed!')));

        final result = await getNotificationDetailUseCase.execute('123');

        expect(result, const Left(ServerFailure('Server Failed!')));
      },
    );
  });
}
