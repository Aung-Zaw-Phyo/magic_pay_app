import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transactions_data.dart';

class TransactionsState extends Equatable {
  final TransactionsDataEntity? transactionsData;
  final String? error;

  const TransactionsState({this.transactionsData, this.error});

  @override
  List<Object?> get props => [transactionsData, error];
}

class TransactionsLoading extends TransactionsState {
  const TransactionsLoading();
}

class TransactionsLoaded extends TransactionsState {
  const TransactionsLoaded(TransactionsDataEntity data)
      : super(transactionsData: data);
}

class TransactionsLoadFailed extends TransactionsState {
  const TransactionsLoadFailed(String error) : super(error: error);
}
