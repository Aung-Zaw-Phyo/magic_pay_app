import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/response_data.dart';
import 'package:magic_pay_app/features/home/domain/usecases/get_profile.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHomeRepository mockHomeRepository;
  late GetProfileUseCase getProfileUseCase;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getProfileUseCase = GetProfileUseCase(mockHomeRepository);
  });

  const testResponseData = ResponseData(
    result: true,
    message: 'success',
    data: 'token data',
  );

  test('should get profile data from the repository', () async {
    // arrange
    when(mockHomeRepository.getProfile())
        .thenAnswer((_) async => const Right(testResponseData));

    // act
    final result = await getProfileUseCase.execute();

    // assert
    expect(result, const Right(testResponseData));
  });
}
