import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transactions_data.dart';
import 'package:magic_pay_app/features/transaction/domain/repositories/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository _transactionRepository;
  const GetTransactionsUseCase(this._transactionRepository);

  Future<Either<Failure, TransactionsDataEntity>> execute(int page) async {
    return _transactionRepository.getTransactions(page);
  }
}
