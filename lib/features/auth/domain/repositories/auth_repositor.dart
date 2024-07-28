import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> register(UserEntity user);

  Future<Either<Failure, String>> login(
      {required String phone, required String password});

  Future<Either<Failure, Null>> logout();
}
