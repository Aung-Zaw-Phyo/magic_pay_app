import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_data.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:magic_pay_app/features/transfer/domain/repositories/transfer_repository.dart';

class TransferConfirmUseCase {
  final TransferRepository _transferRepository;
  const TransferConfirmUseCase(this._transferRepository);

  Future<Either<Failure, TransferDataEntity>> execute(
      TransferRequestEntity transferRequest) async {
    return _transferRepository.transferConfirm(transferRequest);
  }
}
