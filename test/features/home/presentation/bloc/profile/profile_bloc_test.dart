import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/core/response_data.dart';
import 'package:magic_pay_app/features/home/domain/entities/Profile.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_event.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetProfileUseCase mockGetProfileUseCase;
  late ProfileBloc profileBloc;

  setUp(() {
    mockGetProfileUseCase = MockGetProfileUseCase();
    profileBloc = ProfileBloc(mockGetProfileUseCase);
  });

  const profileDataJson = {
    "name": 'Tester',
    "email": 'tester@gmail.com',
    "phone": '123456',
    "account_number": '1223548799654',
    "balance": '3000000',
    'profile': 'profile-image',
    "receive_qr_value": '123456',
    'unread_noti_count': 0,
  };

  const testResponseData = ResponseData(
    result: true,
    message: 'success',
    data: profileDataJson,
  );

  test('initial state should be loading', () {
    expect(profileBloc.state, ProfileLoading());
  });

  group('get profile', () {
    blocTest<ProfileBloc, ProfileState>(
      'should emit [ProfiileLoaded] when data is gotten successfully.',
      build: () {
        when(mockGetProfileUseCase.execute())
            .thenAnswer((_) async => const Right(testResponseData));
        return profileBloc;
      },
      act: (bloc) => bloc.add(const GetProfile()),
      expect: () => [
        ProfileLoaded(ProfileEntity.fromJson(profileDataJson)),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'should emit [ProfileLoadFailed] when data is gotten unsuccessful.',
      build: () {
        when(mockGetProfileUseCase.execute()).thenAnswer(
            (_) async => const Left(ServerFailure("Server failure.")));
        return profileBloc;
      },
      act: (bloc) => bloc.add(const GetProfile()),
      expect: () => [
        const ProfileLoadFailed("Server failure."),
      ],
    );
  });
}
