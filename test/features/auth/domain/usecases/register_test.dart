import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/auth/domain/entities/user.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/register.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late RegisterUseCase registerUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerUseCase = RegisterUseCase(mockAuthRepository);
  });

  const testUser = UserEntity(
    name: 'Tester',
    email: 'tester@gmail.com',
    phone: '0123456789',
    password: 'password',
  );
  const token = 'token string value';

  group('register', () {
    test('should return success response data when register success.',
        () async {
      // arrange
      when(
        mockAuthRepository.register(testUser),
      ).thenAnswer((_) async => const Right(token));

      // act
      final result = await registerUseCase.execute(testUser);

      // assert
      expect(result, const Right(token));
    });

    test('should return server error when register is not success.', () async {
      // arrange
      when(
        mockAuthRepository.register(testUser),
      ).thenAnswer((_) async => const Left(ServerFailure('Server Failed')));

      // act
      final result = await registerUseCase.execute(testUser);

      // assert
      expect(result, const Left(ServerFailure('Server Failed')));
    });
  });
}
