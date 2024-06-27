import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/core/response_data.dart';
import 'package:magic_pay_app/features/auth/domain/entities/user.dart';
import 'package:magic_pay_app/features/auth/domain/repositories/auth_repositor.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;
  const RegisterUseCase(this._authRepository);

  Future<Either<Failure, ResponseData>> execute(UserEntity user) {
    return _authRepository.register(user);
  }
}
