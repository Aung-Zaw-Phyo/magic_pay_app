import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/notification/domain/usecases/get_notification_detail.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_event.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_state.dart';

class NotificationDetailBloc
    extends Bloc<NotificationDetailEvent, NotificationDetailState> {
  final GetNotificationDetailUseCase _getNotificationDetailUseCase;

  NotificationDetailBloc(this._getNotificationDetailUseCase)
      : super(const NotificationDetailLoading()) {
    on<GetNotificationDetail>(onGetNotificationDetail);
  }

  onGetNotificationDetail(GetNotificationDetail event,
      Emitter<NotificationDetailState> emit) async {
    emit(const NotificationDetailLoading());

    final result =
        await _getNotificationDetailUseCase.execute(event.notificationId);

    result.fold((failure) {
      emit(NotificationDetailLoadFailed(failure.message));
    }, (result) {
      emit(NotificationDetailLoaded(result));
    });
  }
}
