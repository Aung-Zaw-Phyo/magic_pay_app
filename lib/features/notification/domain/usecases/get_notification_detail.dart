import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_detail.dart';
import 'package:magic_pay_app/features/notification/domain/repositories/notification_repositor.dart';

class GetNotificationDetailUseCase {
  final NotificationRepository _notificationRepository;
  const GetNotificationDetailUseCase(this._notificationRepository);

  Future<Either<Failure, NotificationDetailEntity>> execute(
      String notificationId) async {
    return _notificationRepository.getNotificationDetail(notificationId);
  }
}
