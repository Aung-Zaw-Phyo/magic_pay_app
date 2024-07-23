import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction_detail.dart';
import 'package:magic_pay_app/features/transaction/domain/usecases/get_transaction_detail.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTransactionRepository mockTransactionRepository;
  late GetTransactionDetailUseCase getTransactionDetailUseCase;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    getTransactionDetailUseCase =
        GetTransactionDetailUseCase(mockTransactionRepository);
  });

  const transactionId = '4549612618172021';
  const testTransactionDetailEntity = TransactionDetailEntity(
    trxId: transactionId,
    refNo: '2165214577780755',
    amount: '3,000.00 MMK',
    type: 1,
    dateTime: '2024-07-22 12:56:57',
    source: 'Mary',
    description: 'Class Fee',
  );

  group('transaction detail', () {
    test(
      'should get transaction detail data from the repository when success',
      () async {
        when(mockTransactionRepository.getTransactionDetail(transactionId))
            .thenAnswer((_) async => const Right(testTransactionDetailEntity));

        final result = await getTransactionDetailUseCase.execute(transactionId);

        expect(result, const Right(testTransactionDetailEntity));
      },
    );

    test(
      'should get server error from the repository when does not success.',
      () async {
        when(mockTransactionRepository.getTransactionDetail(transactionId))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failed!')));

        final result = await getTransactionDetailUseCase.execute(transactionId);

        expect(result, const Left(ServerFailure('Server Failed!')));
      },
    );
  });
}
