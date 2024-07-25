import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/transfer/domain/usecases/transfer_complete.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_complete/transfer_complete_event.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_complete/transfer_complete_state.dart';

class TransferCompleteBloc
    extends Bloc<TransferCompleteEvent, TransferCompleteState> {
  final TransferCompleteUseCase _transferCompleteUseCase;
  TransferCompleteBloc(this._transferCompleteUseCase)
      : super(const TransferCompleteInitial()) {
    on<TransferComplete>(onTransferCompletee);
  }

  void onTransferCompletee(
      TransferComplete event, Emitter<TransferCompleteState> emit) async {
    emit(const TransferCompleteLoading());
    final result =
        await _transferCompleteUseCase.execute(event.transferRequestEntity);
    result.fold((failure) {
      emit(TransferCompleteLoadFailed(failure.message));
    }, (result) {
      emit(TransferCompleteLoaded(result));
    });
  }
}
