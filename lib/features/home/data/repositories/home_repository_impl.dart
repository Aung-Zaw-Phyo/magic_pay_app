import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/home/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/home/domain/entities/Profile.dart';
import 'package:magic_pay_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;
  const HomeRepositoryImpl(this._homeRemoteDataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final result = await _homeRemoteDataSource.getProfile();
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }

  @override
  Future<Either<Failure, Null>> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      final result = await _homeRemoteDataSource.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }
}
