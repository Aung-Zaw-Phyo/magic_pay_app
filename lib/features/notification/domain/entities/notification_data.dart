import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/notification/domain/entities/notification.dart';

class NotificationDataEntity extends Equatable {
  final int currentPage;
  final int lastPage;
  final List<NotificationEntity> notifications;

  const NotificationDataEntity({
    required this.currentPage,
    required this.lastPage,
    required this.notifications,
  });

  @override
  List<Object> get props => [currentPage, lastPage, notifications];
}
