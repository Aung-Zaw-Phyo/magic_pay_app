import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_data_model.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_detail_model.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_model.dart';
import 'package:magic_pay_app/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockNotificationRemoteDataSource mockNotificationRemoteDataSource;
  late NotificationRepositoryImpl notificationRepositoryImpl;

  setUp(() {
    mockNotificationRemoteDataSource = MockNotificationRemoteDataSource();
    notificationRepositoryImpl =
        NotificationRepositoryImpl(mockNotificationRemoteDataSource);
  });

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

  const testNotificationDetailModel = NotificationDetailModel(
    title: "Password Updated",
    message: "Your password updated successfully!",
    dateTime: "2024-07-09 02:07:40 PM",
    deepLink: DeepLinkModel(
      target: "profile",
      parameter: null,
    ),
  );

  group('notifications', () {
    test(
      'should return notifications data when a call to data source is successful',
      () async {
        // arrange
        when(mockNotificationRemoteDataSource.getNotifications(1))
            .thenAnswer((_) async => testNotificationDataModel);

        // act
        final result = await notificationRepositoryImpl.getNotifications(1);

        // assert
        expect(result, equals(const Right(testNotificationDataModel)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockNotificationRemoteDataSource.getNotifications(1))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result = await notificationRepositoryImpl.getNotifications(1);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockNotificationRemoteDataSource.getNotifications(1)).thenThrow(
            const SocketException('Failed to connect to the internet'));

        // act
        final result = await notificationRepositoryImpl.getNotifications(1);

        // assert
        expect(
          result,
          equals(
            const Left(
              ConnectionFailure('Failed to connect to the internet'),
            ),
          ),
        );
      },
    );
  });

  group('notification detail', () {
    test(
      'should return notification detail when a call to data source is successful',
      () async {
        // arrange
        when(mockNotificationRemoteDataSource.getNotificationDetail('123'))
            .thenAnswer((_) async => testNotificationDetailModel);

        // act
        final result =
            await notificationRepositoryImpl.getNotificationDetail('123');

        // assert
        expect(result, equals(const Right(testNotificationDetailModel)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockNotificationRemoteDataSource.getNotificationDetail('123'))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result =
            await notificationRepositoryImpl.getNotificationDetail('123');

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockNotificationRemoteDataSource.getNotificationDetail('123'))
            .thenThrow(
                const SocketException('Failed to connect to the internet'));

        // act
        final result =
            await notificationRepositoryImpl.getNotificationDetail('123');

        // assert
        expect(
          result,
          equals(
            const Left(
              ConnectionFailure('Failed to connect to the internet'),
            ),
          ),
        );
      },
    );
  });
}
