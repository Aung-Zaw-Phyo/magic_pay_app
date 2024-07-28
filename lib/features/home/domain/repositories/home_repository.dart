import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/home/domain/entities/Profile.dart';

abstract class HomeRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();

  Future<Either<Failure, Null>> updatePassword({
    required String oldPassword,
    required String newPassword,
  });
}
