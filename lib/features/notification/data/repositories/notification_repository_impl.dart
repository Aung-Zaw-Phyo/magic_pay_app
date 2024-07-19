import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/notification/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_data.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_detail.dart';
import 'package:magic_pay_app/features/notification/domain/repositories/notification_repositor.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationRemoteDataSource _notificationRemoteDataSource;

  NotificationRepositoryImpl(this._notificationRemoteDataSource);

  @override
  Future<Either<Failure, NotificationDataEntity>> getNotifications(
      int page) async {
    try {
      final result = await _notificationRemoteDataSource.getNotifications(page);
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }

  @override
  Future<Either<Failure, NotificationDetailEntity>> getNotificationDetail(
      String notificationId) async {
    try {
      final result = await _notificationRemoteDataSource
          .getNotificationDetail(notificationId);
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }
}
