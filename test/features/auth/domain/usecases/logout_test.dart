import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/logout.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late LogoutUseCase logoutUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    logoutUseCase = LogoutUseCase(mockAuthRepository);
  });

  group('logout', () {
    test('should return success response data when logout success.', () async {
      // arrange
      when(
        mockAuthRepository.logout(),
      ).thenAnswer((_) async => const Right(null));

      // act
      final result = await logoutUseCase.execute();

      // assert
      expect(result, const Right(null));
    });

    test('should return server eror when logout is not success.', () async {
      // arrange
      when(
        mockAuthRepository.logout(),
      ).thenAnswer((_) async => const Left(ServerFailure('Server Failed')));

      // act
      final result = await logoutUseCase.execute();

      // assert
      expect(result, const Left(ServerFailure('Server Failed')));
    });
  });
}
