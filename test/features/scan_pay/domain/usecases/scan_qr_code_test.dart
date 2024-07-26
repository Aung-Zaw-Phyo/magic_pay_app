import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_form_data.dart';
import 'package:magic_pay_app/features/scan_pay/domain/usecases/scan_qr_code.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockScanPayRepository mockScanPayRepository;
  late ScanQrCodeUseCase scanQrCodeUseCase;

  setUp(() {
    mockScanPayRepository = MockScanPayRepository();
    scanQrCodeUseCase = ScanQrCodeUseCase(mockScanPayRepository);
  });

  const toPhone = '123456';
  const testScanPayFormDataEntity = ScanPayFormDataEntity(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '012345',
    toName: 'Mary',
    toPhone: toPhone,
  );

  group('scan_qr_code', () {
    test(
      'should return scanpay form data from the repository when success',
      () async {
        when(mockScanPayRepository.scanQrCode(toPhone))
            .thenAnswer((_) async => const Right(testScanPayFormDataEntity));

        final result = await scanQrCodeUseCase.execute(toPhone);

        expect(result, const Right(testScanPayFormDataEntity));
      },
    );

    test(
      'should get server error from the repository when success',
      () async {
        when(mockScanPayRepository.scanQrCode(toPhone)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failed')));

        final result = await scanQrCodeUseCase.execute(toPhone);

        expect(result, const Left(ServerFailure('Server Failed')));
      },
    );
  });
}
