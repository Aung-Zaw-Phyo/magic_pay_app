import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/notification/domain/usecases/get_notifications.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_event.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase _getNotificationsUseCase;
  NotificationsBloc(this._getNotificationsUseCase)
      : super(const NotificationsLoading()) {
    on<GetNotifications>(onGetNotifications);
  }

  void onGetNotifications(
      GetNotifications event, Emitter<NotificationsState> emit) async {
    final result = await _getNotificationsUseCase.execute(event.page);

    result.fold((failure) {
      emit(NotificationsLoadFailed(failure.message));
    }, (data) {
      emit(NotificationsLoaded(data));
    });
  }
}
