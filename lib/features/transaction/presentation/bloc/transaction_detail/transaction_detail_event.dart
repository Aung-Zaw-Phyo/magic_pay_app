import 'package:equatable/equatable.dart';

class TransactionDetailEvent extends Equatable {
  const TransactionDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionDetail extends TransactionDetailEvent {
  final String transactionId;
  const GetTransactionDetail(this.transactionId);

  @override
  List<Object> get props => [transactionId];
}
