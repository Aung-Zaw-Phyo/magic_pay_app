import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:magic_pay_app/features/transfer/domain/repositories/transfer_repository.dart';

class TransferCompleteUseCase {
  final TransferRepository _transferRepository;
  const TransferCompleteUseCase(this._transferRepository);

  Future<Either<Failure, String>> execute(
      TransferRequestEntity transferRequest) async {
    return _transferRepository.transferComplete(transferRequest);
  }
}
