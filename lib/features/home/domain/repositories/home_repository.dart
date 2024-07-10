import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/core/response_data.dart';

abstract class HomeRepository {
  Future<Either<Failure, ResponseData>> getProfile();

  Future<Either<Failure, ResponseData>> updatePassword({
    required String oldPassword,
    required String newPassword,
  });
}
