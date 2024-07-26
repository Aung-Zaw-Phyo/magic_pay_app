import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';
import 'package:magic_pay_app/features/scan_pay/domain/repositories/scan_pay_repository.dart';

class PayCompleteUseCase {
  final ScanPayRepository _scanPayRepository;
  const PayCompleteUseCase(this._scanPayRepository);

  Future<Either<Failure, String>> execute(
      ScanPayRequestEntity scanPayRequestEntity) {
    return _scanPayRepository.payComplete(scanPayRequestEntity);
  }
}
