import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transactions_data.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_event.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTransactionsUseCase mockGetTransactionsUseCase;
  late TransactionsBloc transactionsBloc;

  setUp(() {
    mockGetTransactionsUseCase = MockGetTransactionsUseCase();
    transactionsBloc = TransactionsBloc(mockGetTransactionsUseCase);
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

  test('initial state should be loading', () {
    expect(transactionsBloc.state, const TransactionsLoading());
  });

  group('get transactions', () {
    blocTest<TransactionsBloc, TransactionsState>(
      'should emit [TransactionsLoaded] when data is gotten successfully.',
      build: () {
        when(mockGetTransactionsUseCase.execute(1))
            .thenAnswer((_) async => const Right(testTransactionsDataEntity));
        return transactionsBloc;
      },
      act: (bloc) => bloc.add(const GetTransactions(1)),
      expect: () => [
        const TransactionsLoaded(testTransactionsDataEntity),
      ],
    );

    blocTest<TransactionsBloc, TransactionsState>(
      'should emit [TransactionsLoadFailed] when data is gotten unsuccessful.',
      build: () {
        when(mockGetTransactionsUseCase.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure("Server failure.")));
        return transactionsBloc;
      },
      act: (bloc) => bloc.add(const GetTransactions(1)),
      expect: () => [
        const TransactionsLoadFailed("Server failure."),
      ],
    );
  });
}
