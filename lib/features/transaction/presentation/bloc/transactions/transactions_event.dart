import 'package:equatable/equatable.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class GetTransactions extends TransactionsEvent {
  final int page;
  const GetTransactions(this.page);

  @override
  List<Object> get props => [page];
}

class TransactionsRefresh extends TransactionsEvent {
  const TransactionsRefresh();

  @override
  List<Object> get props => [];
}
