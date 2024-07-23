import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/transaction/domain/usecases/get_transactions.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_event.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final GetTransactionsUseCase _getTransactionsUseCase;

  TransactionsBloc(this._getTransactionsUseCase)
      : super(const TransactionsLoading()) {
    on<GetTransactions>(onGetTransactions);
    on<TransactionsRefresh>(onTransactionsRefresh);
  }

  void onGetTransactions(
      GetTransactions event, Emitter<TransactionsState> emit) async {
    final result = await _getTransactionsUseCase.execute(event.page);
    result.fold((failure) {
      emit(TransactionsLoadFailed(failure.message));
    }, (result) {
      final data = state.transactionsData;
      if (data != null) {
        result.transactions.insertAll(0, data.transactions);
      }
      emit(TransactionsLoaded(result));
    });
  }

  void onTransactionsRefresh(
      TransactionsRefresh event, Emitter<TransactionsState> emit) async {
    emit(const TransactionsLoading());
    final result = await _getTransactionsUseCase.execute(1);
    result.fold((failure) {
      emit(TransactionsLoadFailed(failure.message));
    }, (result) {
      emit(TransactionsLoaded(result));
    });
  }
}
