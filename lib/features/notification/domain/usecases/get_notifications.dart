import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_data.dart';
import 'package:magic_pay_app/features/notification/domain/repositories/notification_repositor.dart';

class GetNotificationsUseCase {
  final NotificationRepository _notificationRepository;
  const GetNotificationsUseCase(this._notificationRepository);

  Future<Either<Failure, NotificationDataEntity>> execute(int page) async {
    return _notificationRepository.getNotifications(page);
  }
}
