import 'package:magic_pay_app/features/notification/data/models/notification_model.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification_data.dart';

class NotificationDataModel extends NotificationDataEntity {
  const NotificationDataModel({
    required int currentPage,
    required int lastPage,
    required List<NotificationModel> notifications,
  }) : super(
          currentPage: currentPage,
          lastPage: lastPage,
          notifications: notifications,
        );
}
