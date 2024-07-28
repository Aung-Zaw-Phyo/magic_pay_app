import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/auth/domain/entities/user.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_bloc.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_event.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_state.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late AuthActionBloc authBloc;
  // late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    authBloc = AuthActionBloc(
      loginUseCase: mockLoginUseCase,
      logoutUseCase: mockLogoutUseCase,
      registerUseCase: mockRegisterUseCase,
    );
    // mockSharedPreferences = MockSharedPreferences();
  });

  const token = 'token string value';
  const phone = '123456';
  const password = 'password';
  const testUserEntity = UserEntity(
    name: 'Tester',
    email: 'tester@gmail.com',
    phone: phone,
    password: password,
  );

  test('initial state should be loading', () {
    expect(authBloc.state, AuthInitial());
  });

  group('login', () {
    blocTest<AuthActionBloc, AuthActionState>(
      'should emit [AuthLoading, AuthLoaded] when data is gotten successfully.',
      build: () {
        when(mockLoginUseCase.execute(phone: phone, password: password))
            .thenAnswer((_) async => const Right(token));
        // when(mockSharedPreferences.setString(any, any))
        //     .thenAnswer((_) async => true);
        return authBloc;
      },
      act: (bloc) async =>
          bloc.add(const AuthLogin(phone: phone, password: password)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        AuthLoading(),
        const AuthLoaded(),
      ],
    );

    blocTest<AuthActionBloc, AuthActionState>(
      'should emit [AuthLoading, AuthLoadFailed] when data is gotten unsuccessfully.',
      build: () {
        when(mockLoginUseCase.execute(phone: phone, password: password))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));

        return authBloc;
      },
      act: (bloc) =>
          bloc.add(const AuthLogin(phone: phone, password: password)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        AuthLoading(),
        const AuthLoadFailed(message: 'Server Failure'),
      ],
    );
  });

  group('logout', () {
    blocTest<AuthActionBloc, AuthActionState>(
      'should emit [AuthLoading, AuthLoaded] when data is gotten successfully.',
      build: () {
        when(mockLogoutUseCase.execute())
            .thenAnswer((_) async => const Right(null));

        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthLogout()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        AuthLoading(),
        const AuthLoaded(),
      ],
    );

    blocTest<AuthActionBloc, AuthActionState>(
      'should emit [AuthLoading, AuthLoadFailed] when data is gotten unsuccessfully.',
      build: () {
        when(mockLogoutUseCase.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthLogout()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        AuthLoading(),
        const AuthLoadFailed(message: 'Server Failure'),
      ],
    );
  });

  group('register', () {
    blocTest<AuthActionBloc, AuthActionState>(
      'should emit [AuthLoading, AuthLoaded] when data is gotten successfully.',
      build: () {
        when(mockRegisterUseCase.execute(testUserEntity))
            .thenAnswer((_) async => const Right(token));

        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthRegister(user: testUserEntity)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        AuthLoading(),
        const AuthLoaded(),
      ],
    );

    blocTest<AuthActionBloc, AuthActionState>(
      'should emit [AuthLoading, AuthLoadFailed] when data is gotten unsuccessfully.',
      build: () {
        when(mockRegisterUseCase.execute(testUserEntity)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthRegister(user: testUserEntity)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        AuthLoading(),
        const AuthLoadFailed(message: 'Server Failure'),
      ],
    );
  });
}
