import 'package:dartz/dartz.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/home/domain/entities/Profile.dart';
import 'package:magic_pay_app/features/home/domain/repositories/home_repository.dart';

class GetProfileUseCase {
  final HomeRepository _homeRepository;
  const GetProfileUseCase(this._homeRepository);

  Future<Either<Failure, ProfileEntity>> execute() async {
    return _homeRepository.getProfile();
  }
}
