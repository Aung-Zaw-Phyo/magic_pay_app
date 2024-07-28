import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/auth/domain/repositories/auth_repositor.dart';

class LoginUseCase {
  final AuthRepository _authRepository;
  const LoginUseCase(this._authRepository);

  Future<Either<Failure, String>> execute(
      {required String phone, required String password}) {
    return _authRepository.login(phone: phone, password: password);
  }
}
