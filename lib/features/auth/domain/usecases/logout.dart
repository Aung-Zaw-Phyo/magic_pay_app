import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/core/response_data.dart';
import 'package:magic_pay_app/features/auth/domain/repositories/auth_repositor.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;
  const LogoutUseCase(this._authRepository);

  Future<Either<Failure, ResponseData>> execute() {
    return _authRepository.logout();
  }
}
