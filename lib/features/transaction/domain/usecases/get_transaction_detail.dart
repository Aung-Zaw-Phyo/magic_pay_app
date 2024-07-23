import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction_detail.dart';
import 'package:magic_pay_app/features/transaction/domain/repositories/transaction_repository.dart';

class GetTransactionDetailUseCase {
  final TransactionRepository _notificationRepository;
  const GetTransactionDetailUseCase(this._notificationRepository);

  Future<Either<Failure, TransactionDetailEntity>> execute(
      String transactionId) async {
    return _notificationRepository.getTransactionDetail(transactionId);
  }
}
