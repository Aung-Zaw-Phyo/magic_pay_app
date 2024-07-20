import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_detail.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_bloc.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_event.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetNotificationDetailUseCase mockGetNotificationDetailUseCase;
  late NotificationDetailBloc notificationDetailBloc;

  setUp(() {
    mockGetNotificationDetailUseCase = MockGetNotificationDetailUseCase();
    notificationDetailBloc =
        NotificationDetailBloc(mockGetNotificationDetailUseCase);
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

  test('initial state should be loading', () {
    expect(notificationDetailBloc.state, const NotificationDetailLoading());
  });

  group('get notification detail', () {
    blocTest<NotificationDetailBloc, NotificationDetailState>(
      'should emit [NotificationDetailLoaded] when data is gotten successfully.',
      build: () {
        when(mockGetNotificationDetailUseCase.execute('123'))
            .thenAnswer((_) async => const Right(testNotificationDetailEntity));
        return notificationDetailBloc;
      },
      act: (bloc) => bloc.add(const GetNotificationDetail('123')),
      expect: () => [
        const NotificationDetailLoading(),
        const NotificationDetailLoaded(testNotificationDetailEntity),
      ],
    );

    blocTest<NotificationDetailBloc, NotificationDetailState>(
      'should emit [NotificationDetailLoadFailed] when data is gotten unsuccessful.',
      build: () {
        when(mockGetNotificationDetailUseCase.execute('123')).thenAnswer(
            (_) async => const Left(ServerFailure("Server failure.")));
        return notificationDetailBloc;
      },
      act: (bloc) => bloc.add(const GetNotificationDetail('123')),
      expect: () => [
        const NotificationDetailLoading(),
        const NotificationDetailLoadFailed("Server failure."),
      ],
    );
  });
}
