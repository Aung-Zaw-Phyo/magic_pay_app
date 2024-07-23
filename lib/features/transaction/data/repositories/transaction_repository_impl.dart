import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transaction/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction_detail.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transactions_data.dart';
import 'package:magic_pay_app/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionRemoteDataSource _transactionRemoteDataSource;
  TransactionRepositoryImpl(this._transactionRemoteDataSource);

  @override
  Future<Either<Failure, TransactionsDataEntity>> getTransactions(
      int page) async {
    try {
      final result = await _transactionRemoteDataSource.getTransactions(page);
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }

  @override
  Future<Either<Failure, TransactionDetailEntity>> getTransactionDetail(
      String transactionId) async {
    try {
      final result = await _transactionRemoteDataSource
          .getTransactionDetail(transactionId);
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }
}
