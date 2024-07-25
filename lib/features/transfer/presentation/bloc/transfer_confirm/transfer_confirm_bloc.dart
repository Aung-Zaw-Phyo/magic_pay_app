import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/transfer/domain/usecases/transfer_confirm.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_event.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_state.dart';

class TransferConfirmBloc
    extends Bloc<TransferConfirmEvent, TransferConfirmState> {
  final TransferConfirmUseCase _transferConfirmUseCase;
  TransferConfirmBloc(this._transferConfirmUseCase)
      : super(const TransferConfirmInitial()) {
    on<TransferConfirm>(onTransferConfirme);
  }

  void onTransferConfirme(
      TransferConfirm event, Emitter<TransferConfirmState> emit) async {
    emit(const TransferConfirmLoading());
    final result =
        await _transferConfirmUseCase.execute(event.transferRequestEntity);
    result.fold((failure) {
      emit(TransferConfirmLoadFailed(failure.message));
    }, (result) {
      emit(TransferConfirmLoaded(result));
    });
  }
}
