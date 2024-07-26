import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_form_data.dart';
import 'package:magic_pay_app/features/scan_pay/domain/repositories/scan_pay_repository.dart';

class ScanQrCodeUseCase {
  final ScanPayRepository _scanPayRepository;
  const ScanQrCodeUseCase(this._scanPayRepository);

  Future<Either<Failure, ScanPayFormDataEntity>> execute(String toPhone) {
    return _scanPayRepository.scanQrCode(toPhone);
  }
}
