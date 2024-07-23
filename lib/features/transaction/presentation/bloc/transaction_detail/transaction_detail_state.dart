import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction_detail.dart';

class TransactionDetailState extends Equatable {
  const TransactionDetailState();

  @override
  List<Object> get props => [];
}

class TransactionDetailLoading extends TransactionDetailState {
  const TransactionDetailLoading();
}

class TransactionDetailLoaded extends TransactionDetailState {
  final TransactionDetailEntity transaction;
  const TransactionDetailLoaded(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class TransactionDetailLoadFailed extends TransactionDetailState {
  final String message;
  const TransactionDetailLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
