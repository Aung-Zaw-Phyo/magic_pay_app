import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/core/response_data.dart';
import 'package:magic_pay_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, ResponseData>> register(UserEntity user);

  Future<Either<Failure, ResponseData>> login(
      {required String phone, required String password});

  Future<Either<Failure, ResponseData>> logout();
}
