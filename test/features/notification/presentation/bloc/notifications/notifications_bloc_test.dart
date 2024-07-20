import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_data.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_event.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetNotificationsUseCase mockGetNotificationsUseCase;
  late NotificationsBloc notificationsBloc;

  setUp(() {
    mockGetNotificationsUseCase = MockGetNotificationsUseCase();
    notificationsBloc = NotificationsBloc(mockGetNotificationsUseCase);
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

  test('initial state should be loading', () {
    expect(notificationsBloc.state, const NotificationsLoading());
  });

  group('get notifications', () {
    blocTest<NotificationsBloc, NotificationsState>(
      'should emit [NotificationsLoaded] when data is gotten successfully.',
      build: () {
        when(mockGetNotificationsUseCase.execute(1))
            .thenAnswer((_) async => const Right(testNotificationDataEntity));
        return notificationsBloc;
      },
      act: (bloc) => bloc.add(const GetNotifications(1)),
      expect: () => [
        const NotificationsLoaded(testNotificationDataEntity),
      ],
    );

    blocTest<NotificationsBloc, NotificationsState>(
      'should emit [NotificationsLoadFailed] when data is gotten unsuccessful.',
      build: () {
        when(mockGetNotificationsUseCase.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure("Server failure.")));
        return notificationsBloc;
      },
      act: (bloc) => bloc.add(const GetNotifications(1)),
      expect: () => [
        const NotificationsLoadFailed("Server failure."),
      ],
    );
  });
}
