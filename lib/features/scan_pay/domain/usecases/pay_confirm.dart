import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_data.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';
import 'package:magic_pay_app/features/scan_pay/domain/repositories/scan_pay_repository.dart';

class PayConfirmUseCase {
  final ScanPayRepository _scanPayRepository;
  const PayConfirmUseCase(this._scanPayRepository);

  Future<Either<Failure, ScanPayDataEntity>> execute(
      ScanPayRequestEntity scanPayRequestEntity) {
    return _scanPayRepository.payConfirm(scanPayRequestEntity);
  }
}
