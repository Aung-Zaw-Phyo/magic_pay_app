import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction_detail.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transactions_data.dart';

abstract class TransactionRepository {
  Future<Either<Failure, TransactionsDataEntity>> getTransactions(int page);

  Future<Either<Failure, TransactionDetailEntity>> getTransactionDetail(
      String transactionId);
}
