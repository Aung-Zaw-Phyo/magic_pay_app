import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_data.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';

abstract class TransferRepository {
  Future<Either<Failure, TransferDataEntity>> transferConfirm(
      TransferRequestEntity transferRequest);

  Future<Either<Failure, String>> transferComplete(
      TransferRequestEntity transferRequest);
}
