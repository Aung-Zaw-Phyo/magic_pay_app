import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/core/response_data.dart';
import 'package:magic_pay_app/features/home/domain/repositories/home_repository.dart';

class UpdatePasswordUseCase {
  final HomeRepository _homeRepository;
  const UpdatePasswordUseCase(this._homeRepository);

  Future<Either<Failure, ResponseData>> execute({
    required String oldPassword,
    required String newPassword,
  }) async {
    return _homeRepository.updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
