import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction_detail.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_bloc.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_event.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTransactionDetailUseCase mockGetTransactionDetailUseCase;
  late TransactionDetailBloc transactionDetailBloc;

  setUp(() {
    mockGetTransactionDetailUseCase = MockGetTransactionDetailUseCase();
    transactionDetailBloc =
        TransactionDetailBloc(mockGetTransactionDetailUseCase);
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

  test('initial state should be loading', () {
    expect(transactionDetailBloc.state, const TransactionDetailLoading());
  });

  group('get transaction detail', () {
    blocTest<TransactionDetailBloc, TransactionDetailState>(
      'should emit [TransactionDetailLoaded] when data is gotten successfully.',
      build: () {
        when(mockGetTransactionDetailUseCase.execute(transactionId))
            .thenAnswer((_) async => const Right(testTransactionDetailEntity));
        return transactionDetailBloc;
      },
      act: (bloc) => bloc.add(const GetTransactionDetail(transactionId)),
      expect: () => [
        const TransactionDetailLoading(),
        const TransactionDetailLoaded(testTransactionDetailEntity),
      ],
    );

    blocTest<TransactionDetailBloc, TransactionDetailState>(
      'should emit [TransactionDetailLoadFailed] when data is gotten unsuccessful.',
      build: () {
        when(mockGetTransactionDetailUseCase.execute(transactionId)).thenAnswer(
            (_) async => const Left(ServerFailure("Server failure.")));
        return transactionDetailBloc;
      },
      act: (bloc) => bloc.add(const GetTransactionDetail(transactionId)),
      expect: () => [
        const TransactionDetailLoading(),
        const TransactionDetailLoadFailed("Server failure."),
      ],
    );
  });
}
