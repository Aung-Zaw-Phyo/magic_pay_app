import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/domain/usecases/pay_confirm.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_state.dart';

class PayConfirmBloc extends Bloc<PayConfirmEvent, PayConfirmState> {
  final PayConfirmUseCase _payConfirmUseCase;

  PayConfirmBloc(this._payConfirmUseCase) : super(const PayConfirmInitial()) {
    on<PayConfirm>(onPayConfirme);
  }

  void onPayConfirme(PayConfirm event, Emitter<PayConfirmState> emit) async {
    emit(const PayConfirmLoading());
    final result = await _payConfirmUseCase.execute(event.scanPayRequestEntity);
    result.fold((failure) {
      emit(PayConfirmLoadFailed(failure.message));
    }, (result) {
      emit(PayConfirmLoaded(result));
    });
  }
}
