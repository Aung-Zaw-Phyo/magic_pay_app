import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_data.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_form_data.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';

abstract class ScanPayRepository {
  Future<Either<Failure, ScanPayFormDataEntity>> scanQrCode(String toPhone);
  Future<Either<Failure, ScanPayDataEntity>> payConfirm(
      ScanPayRequestEntity scanPayRequestEntity);
  Future<Either<Failure, String>> payComplete(
      ScanPayRequestEntity scanPayRequestEntity);
}
