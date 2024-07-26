import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_data.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';
import 'package:magic_pay_app/features/scan_pay/domain/usecases/pay_confirm.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockScanPayRepository mockScanPayRepository;
  late PayConfirmUseCase payConfirmUseCase;

  setUp(() {
    mockScanPayRepository = MockScanPayRepository();
    payConfirmUseCase = PayConfirmUseCase(mockScanPayRepository);
  });

  const testScanPayRequestEntity = ScanPayRequestEntity(
    toPhone: '122123',
    amount: 3000,
    hashValue: 'hashValue',
    description: 'description',
  );

  const testScanPayDataEntity = ScanPayDataEntity(
    fromName: '012345',
    fromPhone: 'Aung Zaw Phyo',
    toName: '122123',
    toPhone: 'Mary',
    amount: 3000,
    hashValue: 'hashValue',
  );

  group('pay confirm', () {
    test(
      'should return scanpay data from the repository when success',
      () async {
        when(mockScanPayRepository.payConfirm(testScanPayRequestEntity))
            .thenAnswer((_) async => const Right(testScanPayDataEntity));

        final result =
            await payConfirmUseCase.execute(testScanPayRequestEntity);

        expect(result, const Right(testScanPayDataEntity));
      },
    );

    test(
      'should get server error from the repository when is not success',
      () async {
        when(mockScanPayRepository.payConfirm(testScanPayRequestEntity))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failed')));

        final result =
            await payConfirmUseCase.execute(testScanPayRequestEntity);

        expect(result, const Left(ServerFailure('Server Failed')));
      },
    );
  });
}
