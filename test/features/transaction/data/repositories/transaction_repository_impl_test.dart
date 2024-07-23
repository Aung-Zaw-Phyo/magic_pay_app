import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transaction/data/models/transaction_detail_model.dart';
import 'package:magic_pay_app/features/transaction/data/models/transaction_model.dart';
import 'package:magic_pay_app/features/transaction/data/models/transactions_data_model.dart';
import 'package:magic_pay_app/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTransactionRemoteDataSource mockTransactionRemoteDataSource;
  late TransactionRepositoryImpl transactionRepositoryImpl;

  setUp(() {
    mockTransactionRemoteDataSource = MockTransactionRemoteDataSource();
    transactionRepositoryImpl =
        TransactionRepositoryImpl(mockTransactionRemoteDataSource);
  });

  const transactionId = '4549612618172021';
  const testTransactions = [
    TransactionModel(
      trxId: transactionId,
      amount: "3,000.00 MMK",
      type: 1,
      title: "From Mary",
      dateTime: "2024-07-22 12:56:57",
    ),
    TransactionModel(
      trxId: '456',
      amount: "3,000.00 MMK",
      type: 1,
      title: "From Mary",
      dateTime: "2024-07-22 12:56:57",
    ),
  ];

  const testTransactionsDataModel = TransactionsDataModel(
    currentPage: 1,
    lastPage: 2,
    transactions: testTransactions,
  );

  const testTransactionDetailModel = TransactionDetailModel(
    trxId: transactionId,
    refNo: '2165214577780755',
    amount: '3,000.00 MMK',
    type: 1,
    dateTime: '2024-07-22 12:56:57',
    source: 'Mary',
    description: 'Class Fee',
  );

  group('transactions', () {
    test(
      'should return transactions data when a call to data source is successful',
      () async {
        // arrange
        when(mockTransactionRemoteDataSource.getTransactions(1))
            .thenAnswer((_) async => testTransactionsDataModel);

        // act
        final result = await transactionRepositoryImpl.getTransactions(1);

        // assert
        expect(result, equals(const Right(testTransactionsDataModel)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockTransactionRemoteDataSource.getTransactions(1))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result = await transactionRepositoryImpl.getTransactions(1);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockTransactionRemoteDataSource.getTransactions(1)).thenThrow(
            const SocketException('Failed to connect to the internet'));

        // act
        final result = await transactionRepositoryImpl.getTransactions(1);

        // assert
        expect(
          result,
          equals(
            const Left(
              ConnectionFailure('Failed to connect to the internet'),
            ),
          ),
        );
      },
    );
  });

  group('transaction detail', () {
    test(
      'should return transaction detail when a call to data source is successful',
      () async {
        // arrange
        when(mockTransactionRemoteDataSource
                .getTransactionDetail(transactionId))
            .thenAnswer((_) async => testTransactionDetailModel);

        // act
        final result =
            await transactionRepositoryImpl.getTransactionDetail(transactionId);

        // assert
        expect(result, equals(const Right(testTransactionDetailModel)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockTransactionRemoteDataSource
                .getTransactionDetail(transactionId))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result =
            await transactionRepositoryImpl.getTransactionDetail(transactionId);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockTransactionRemoteDataSource
                .getTransactionDetail(transactionId))
            .thenThrow(
                const SocketException('Failed to connect to the internet'));

        // act
        final result =
            await transactionRepositoryImpl.getTransactionDetail(transactionId);

        // assert
        expect(
          result,
          equals(
            const Left(
              ConnectionFailure('Failed to connect to the internet'),
            ),
          ),
        );
      },
    );
  });
}
