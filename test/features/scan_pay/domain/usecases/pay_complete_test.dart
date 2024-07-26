import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';
import 'package:magic_pay_app/features/scan_pay/domain/usecases/pay_complete.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockScanPayRepository mockScanPayRepository;
  late PayCompleteUseCase payCompleteUseCase;

  const testScanPayRequestEntity = ScanPayRequestEntity(
    toPhone: '122123',
    amount: 3000,
    hashValue: 'hashValue',
    description: 'description',
  );
  const trxId = '5454121212121';

  setUp(() {
    mockScanPayRepository = MockScanPayRepository();
    payCompleteUseCase = PayCompleteUseCase(mockScanPayRepository);
  });

  group('pay complete', () {
    test('should return trxId string from the repository when success',
        () async {
      when(mockScanPayRepository.payComplete(testScanPayRequestEntity))
          .thenAnswer((_) async => const Right(trxId));

      final result = await payCompleteUseCase.execute(testScanPayRequestEntity);

      expect(result, const Right(trxId));
    });

    test('should get server error from the repository when is not success',
        () async {
      when(mockScanPayRepository.payComplete(testScanPayRequestEntity))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failed')));

      final result = await payCompleteUseCase.execute(testScanPayRequestEntity);

      expect(result, const Left(ServerFailure('Server Failed')));
    });
  });
}
