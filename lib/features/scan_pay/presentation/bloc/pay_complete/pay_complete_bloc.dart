import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/domain/usecases/pay_complete.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_complete/pay_complete_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_complete/pay_complete_state.dart';

class PayCompleteBloc extends Bloc<PayCompleteEvent, PayCompleteState> {
  final PayCompleteUseCase _payCompleteUseCase;

  PayCompleteBloc(this._payCompleteUseCase)
      : super(const PayCompleteInitial()) {
    on<PayComplete>(onPayCompletee);
  }

  void onPayCompletee(PayComplete event, Emitter<PayCompleteState> emit) async {
    emit(const PayCompleteLoading());
    final result =
        await _payCompleteUseCase.execute(event.scanPayRequestEntity);
    result.fold((failure) {
      emit(PayCompleteLoadFailed(failure.message));
    }, (result) {
      emit(PayCompleteLoaded(result));
    });
  }
}
