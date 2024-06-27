import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/core/response_data.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/login.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  const phone = '0123456789';
  const password = 'password';

  const testReponseData = ResponseData(
    result: true,
    message: 'Successfully logined.',
    data: 'token data',
  );

  group('login', () {
    test('should return success response data when login success.', () async {
      // arrange
      when(
        mockAuthRepository.login(phone: phone, password: password),
      ).thenAnswer((_) async => const Right(testReponseData));

      // act
      final result =
          await loginUseCase.execute(phone: phone, password: password);

      // assert
      expect(result, const Right(testReponseData));
    });

    test('should return server error when login is not success.', () async {
      // arrange
      when(
        mockAuthRepository.login(phone: phone, password: password),
      ).thenAnswer((_) async => const Left(ServerFailure('Server Failed')));

      // act
      final result =
          await loginUseCase.execute(phone: phone, password: password);

      // assert
      expect(result, const Left(ServerFailure('Server Failed')));
    });
  });
}
