import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:magic_pay_app/features/transfer/domain/usecases/transfer_complete.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTransferRepository mockTransferRepository;
  late TransferCompleteUseCase transferCompleteUseCase;

  setUp(() {
    mockTransferRepository = MockTransferRepository();
    transferCompleteUseCase = TransferCompleteUseCase(mockTransferRepository);
  });

  const testTransferRequestEntity = TransferRequestEntity(
    toPhone: '09968548025',
    amount: 3000,
    hashValue: 'hashValue',
    password: 'password',
  );
  const trxId = '98798798';

  group('Transfer Complete', () {
    test(
      'should get transaction id string from the repository when success',
      () async {
        when(mockTransferRepository.transferComplete(testTransferRequestEntity))
            .thenAnswer((_) async => const Right(trxId));

        final result =
            await transferCompleteUseCase.execute(testTransferRequestEntity);

        expect(result, const Right(trxId));
      },
    );

    test(
      'should get server error from the repository when does not success.',
      () async {
        when(mockTransferRepository.transferComplete(testTransferRequestEntity))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failed')));

        final result =
            await transferCompleteUseCase.execute(testTransferRequestEntity);

        expect(result, const Left(ServerFailure('Server Failed')));
      },
    );
  });
}
