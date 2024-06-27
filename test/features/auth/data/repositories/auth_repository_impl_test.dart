import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/core/response_data.dart';
import 'package:magic_pay_app/features/auth/data/models/user.dart';
import 'package:magic_pay_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepositoryImpl authRepositoryImpl;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepositoryImpl = AuthRepositoryImpl(mockAuthRemoteDataSource);
  });

  const phone = '0123456';
  const password = 'password';

  const testReponseData = ResponseData(
    result: true,
    message: 'success',
    data: 'data',
  );

  // Login Test
  group('login', () {
    test(
      'should return success login data when a call to data source is successful',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.login(phone: phone, password: password))
            .thenAnswer((_) async => testReponseData);

        // act
        final result =
            await authRepositoryImpl.login(phone: phone, password: password);

        // assert
        expect(result, equals(const Right(testReponseData)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.login(phone: phone, password: password))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result =
            await authRepositoryImpl.login(phone: phone, password: password);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.login(phone: phone, password: password))
            .thenThrow(
                const SocketException('Failed to connect to the internet'));

        // act
        final result =
            await authRepositoryImpl.login(phone: phone, password: password);

        // assert
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the internet'))));
      },
    );
  });

  // Logout Test
  group('logout', () {
    test(
      'should return success logout data when a call to data source is successful',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.logout())
            .thenAnswer((_) async => testReponseData);

        // act
        final result = await authRepositoryImpl.logout();

        // assert
        expect(result, equals(const Right(testReponseData)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.logout())
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result = await authRepositoryImpl.logout();

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.logout()).thenThrow(
            const SocketException('Failed to connect to the internet'));

        // act
        final result = await authRepositoryImpl.logout();

        // assert
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the internet'))));
      },
    );
  });

  // Register Test
  const testUserModel = UserModel(
    name: 'Tester',
    email: 'tester@gmail.com',
    phone: '123456',
    password: 'password',
  );

  group('register', () {
    test(
      'should return success register data when a call to data source is successful',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.register(testUserModel))
            .thenAnswer((_) async => testReponseData);

        // act
        final result = await authRepositoryImpl.register(testUserModel);

        // assert
        expect(result, equals(const Right(testReponseData)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.register(testUserModel))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result = await authRepositoryImpl.register(testUserModel);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockAuthRemoteDataSource.register(testUserModel)).thenThrow(
            const SocketException('Failed to connect to the internet'));

        // act
        final result = await authRepositoryImpl.register(testUserModel);

        // assert
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the internet'))));
      },
    );
  });
}
