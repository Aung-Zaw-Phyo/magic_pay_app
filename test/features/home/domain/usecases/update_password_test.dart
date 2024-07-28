import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/home/domain/usecases/update_password.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHomeRepository mockHomeRepository;
  late UpdatePasswordUseCase updatePasswordUseCase;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    updatePasswordUseCase = UpdatePasswordUseCase(mockHomeRepository);
  });
  const oldPassword = '0987654321';
  const newPassword = '1234567890';

  test('should return success response data from the repository', () async {
    // arrange
    when(mockHomeRepository.updatePassword(
            oldPassword: oldPassword, newPassword: newPassword))
        .thenAnswer((_) async => const Right(null));

    // act
    final result = await updatePasswordUseCase.execute(
        oldPassword: oldPassword, newPassword: newPassword);

    // assert
    expect(result, const Right(null));
  });
}
