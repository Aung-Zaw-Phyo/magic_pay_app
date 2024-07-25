import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_data.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:magic_pay_app/features/transfer/domain/usecases/transfer_confirm.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTransferRepository mockTransferRepository;
  late TransferConfirmUseCase transferConfirmUseCase;

  setUp(() {
    mockTransferRepository = MockTransferRepository();
    transferConfirmUseCase = TransferConfirmUseCase(mockTransferRepository);
  });

  const testTransferRequestEntity = TransferRequestEntity(
    toPhone: '09968548025',
    amount: 3000,
    hashValue: 'hashValue',
  );
  const testTransferDataEntity = TransferDataEntity(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '09968548024',
    toName: 'Mary',
    toPhone: '09968548025',
    amount: 3000,
    description: 'description',
    hashValue: 'hashValue',
  );

  group('Transfer Confirm', () {
    test(
      'should get transfer data from the repository when success',
      () async {
        when(mockTransferRepository.transferConfirm(testTransferRequestEntity))
            .thenAnswer((_) async => const Right(testTransferDataEntity));

        final result =
            await transferConfirmUseCase.execute(testTransferRequestEntity);

        expect(result, const Right(testTransferDataEntity));
      },
    );

    test(
      'should get server error from the repository when does not success.',
      () async {
        when(mockTransferRepository.transferConfirm(testTransferRequestEntity))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failed')));

        final result =
            await transferConfirmUseCase.execute(testTransferRequestEntity);

        expect(result, const Left(ServerFailure('Server Failed')));
      },
    );
  });
}
