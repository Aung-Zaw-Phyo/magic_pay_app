import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transactions_data.dart';
import 'package:magic_pay_app/features/transaction/domain/usecases/get_transactions.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTransactionRepository mockTransactionRepository;
  late GetTransactionsUseCase getTransactionsUseCase;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    getTransactionsUseCase = GetTransactionsUseCase(mockTransactionRepository);
  });

  const testTransactions = [
    TransactionEntity(
      trxId: '123',
      amount: "3,000.00 MMK",
      type: 1,
      title: "From Mary",
      dateTime: "2024-07-22 12:56:57",
    ),
    TransactionEntity(
      trxId: '456',
      amount: "3,000.00 MMK",
      type: 1,
      title: "From Mary",
      dateTime: "2024-07-22 12:56:57",
    ),
  ];

  const testTransactionsDataEntity = TransactionsDataEntity(
    currentPage: 1,
    lastPage: 2,
    transactions: testTransactions,
  );

  group('get transactions', () {
    test(
      'should get transactions data from the repository when success',
      () async {
        when(mockTransactionRepository.getTransactions(1))
            .thenAnswer((_) async => const Right(testTransactionsDataEntity));

        final result = await getTransactionsUseCase.execute(1);

        expect(result, const Right(testTransactionsDataEntity));
      },
    );

    test(
      'should get server error from the repository when does not success.',
      () async {
        when(mockTransactionRepository.getTransactions(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failed!')));

        final result = await getTransactionsUseCase.execute(1);

        expect(result, const Left(ServerFailure('Server Failed!')));
      },
    );
  });
}
