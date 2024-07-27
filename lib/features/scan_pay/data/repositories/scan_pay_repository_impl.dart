import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/data/datasources/remote_data_source.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_data.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_form_data.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';
import 'package:magic_pay_app/features/scan_pay/domain/repositories/scan_pay_repository.dart';

class ScanPayRepositoryImpl extends ScanPayRepository {
  final ScanPayRemoteDataSource _scanPayRemoteDataSource;

  ScanPayRepositoryImpl(this._scanPayRemoteDataSource);

  @override
  Future<Either<Failure, ScanPayFormDataEntity>> scanQrCode(
      String toPhone) async {
    try {
      final result = await _scanPayRemoteDataSource.scanQrCode(toPhone);
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }

  @override
  Future<Either<Failure, ScanPayDataEntity>> payConfirm(
      ScanPayRequestEntity scanPayRequestEntity) async {
    try {
      final result = await _scanPayRemoteDataSource
          .payConfirm(scanPayRequestEntity.toModel());
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }

  @override
  Future<Either<Failure, String>> payComplete(
      ScanPayRequestEntity scanPayRequestEntity) async {
    try {
      final result = await _scanPayRemoteDataSource
          .payComplete(scanPayRequestEntity.toModel());
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }
}
