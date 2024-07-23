import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction.dart';

class TransactionsDataEntity extends Equatable {
  final int currentPage;
  final int lastPage;
  final List<TransactionEntity> transactions;

  const TransactionsDataEntity({
    required this.currentPage,
    required this.lastPage,
    required this.transactions,
  });

  @override
  List<Object> get props => [currentPage, lastPage, transactions];
}
