import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_data.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_detail.dart';

abstract class NotificationRepository {
  Future<Either<Failure, NotificationDataEntity>> getNotifications(int page);

  Future<Either<Failure, NotificationDetailEntity>> getNotificationDetail(
      String notificationId);
}
