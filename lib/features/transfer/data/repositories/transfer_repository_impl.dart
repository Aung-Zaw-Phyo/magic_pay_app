import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transfer/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_data.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';
import 'package:magic_pay_app/features/transfer/domain/repositories/transfer_repository.dart';

class TransferRepositoryImpl extends TransferRepository {
  final TransferRemoteDataSource _transferRemoteDataSource;
  TransferRepositoryImpl(this._transferRemoteDataSource);

  @override
  Future<Either<Failure, TransferDataEntity>> transferConfirm(
      TransferRequestEntity transferRequest) async {
    try {
      final result = await _transferRemoteDataSource
          .transferConfirm(transferRequest.toModel());
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }

  @override
  Future<Either<Failure, String>> transferComplete(
      TransferRequestEntity transferRequest) async {
    try {
      final result = await _transferRemoteDataSource
          .transferComplete(transferRequest.toModel());
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }
}
