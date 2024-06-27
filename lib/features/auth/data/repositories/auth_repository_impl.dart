import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/core/response_data.dart';
import 'package:magic_pay_app/features/auth/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/auth/domain/entities/user.dart';
import 'package:magic_pay_app/features/auth/domain/repositories/auth_repositor.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, ResponseData>> login(
      {required String phone, required String password}) async {
    try {
      final result =
          await _authRemoteDataSource.login(phone: phone, password: password);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }

  @override
  Future<Either<Failure, ResponseData>> logout() async {
    try {
      final result = await _authRemoteDataSource.logout();
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }

  @override
  Future<Either<Failure, ResponseData>> register(UserEntity user) async {
    try {
      final result = await _authRemoteDataSource.register(user.toModel());
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }
}
