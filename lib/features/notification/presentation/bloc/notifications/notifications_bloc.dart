import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/notification/domain/usecases/get_notifications.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_event.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase _getNotificationsUseCase;

  NotificationsBloc(this._getNotificationsUseCase)
      : super(const NotificationsLoading()) {
    on<GetNotifications>(onGetNotifications);
    on<NotificationsRefresh>(onNotificationsRefresh);
  }

  void onGetNotifications(
      GetNotifications event, Emitter<NotificationsState> emit) async {
    final result = await _getNotificationsUseCase.execute(event.page);
    result.fold((failure) {
      emit(NotificationsLoadFailed(failure.message));
    }, (result) {
      final data = state.notificationData;
      if (data != null) {
        result.notifications.insertAll(0, data.notifications);
      }
      emit(NotificationsLoaded(result));
    });
  }

  void onNotificationsRefresh(
      NotificationsRefresh event, Emitter<NotificationsState> emit) async {
    emit(const NotificationsLoading());
    final result = await _getNotificationsUseCase.execute(1);
    result.fold((failure) {
      emit(NotificationsLoadFailed(failure.message));
    }, (result) {
      emit(NotificationsLoaded(result));
    });
  }
}
