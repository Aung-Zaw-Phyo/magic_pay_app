import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/home/domain/entities/Profile.dart';
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

  const profileEntity = ProfileEntity(
    name: "Tester",
    email: "tester@gmail.com",
    phone: "123456",
    accountNumber: "876872478236478234",
    balance: "300000",
    profile: "profile image",
    receiveQrValue: "123456",
    unreadNotiCount: 0,
  );

  test('should get profile data from the repository', () async {
    // arrange
    when(mockHomeRepository.getProfile())
        .thenAnswer((_) async => const Right(profileEntity));

    // act
    final result = await getProfileUseCase.execute();

    // assert
    expect(result, const Right(profileEntity));
  });
}
