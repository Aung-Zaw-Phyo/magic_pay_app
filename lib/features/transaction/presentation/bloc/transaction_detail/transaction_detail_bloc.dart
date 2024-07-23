import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/transaction/domain/usecases/get_transaction_detail.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_event.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_state.dart';

class TransactionDetailBloc
    extends Bloc<TransactionDetailEvent, TransactionDetailState> {
  final GetTransactionDetailUseCase _getTransactionDetailUseCase;

  TransactionDetailBloc(this._getTransactionDetailUseCase)
      : super(const TransactionDetailLoading()) {
    on<GetTransactionDetail>(onGetTransactionDetail);
  }

  onGetTransactionDetail(
      GetTransactionDetail event, Emitter<TransactionDetailState> emit) async {
    emit(const TransactionDetailLoading());

    final result =
        await _getTransactionDetailUseCase.execute(event.transactionId);

    result.fold((failure) {
      emit(TransactionDetailLoadFailed(failure.message));
    }, (result) {
      emit(TransactionDetailLoaded(result));
    });
  }
}
