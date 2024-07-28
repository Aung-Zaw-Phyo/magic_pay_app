import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/home/data/models/profile_model.dart';
import 'package:magic_pay_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;
  late HomeRepositoryImpl homeRepositoryImpl;

  setUp(() {
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    homeRepositoryImpl = HomeRepositoryImpl(mockHomeRemoteDataSource);
  });

  const testProfileModel = ProfileModel(
    name: "Tester",
    email: "tester@gmail.com",
    phone: "123456",
    accountNumber: "876872478236478234",
    balance: "300000",
    profile: "profile image",
    receiveQrValue: "123456",
    unreadNotiCount: 0,
  );

  const oldPassword = 'password-old';
  const newPassword = 'password-new';

  group('profile', () {
    test(
      'should return success data when a call to data source is successful',
      () async {
        // arrange
        when(mockHomeRemoteDataSource.getProfile())
            .thenAnswer((_) async => testProfileModel);

        // act
        final result = await homeRepositoryImpl.getProfile();

        // assert
        expect(result, equals(const Right(testProfileModel)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockHomeRemoteDataSource.getProfile())
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result = await homeRepositoryImpl.getProfile();

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockHomeRemoteDataSource.getProfile()).thenThrow(
            const SocketException('Failed to connect to the internet'));

        // act
        final result = await homeRepositoryImpl.getProfile();

        // assert
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the internet'))));
      },
    );
  });

  group('update password', () {
    test(
      'should return success data when a call to data source is successful',
      () async {
        // arrange
        when(mockHomeRemoteDataSource.updatePassword(
                oldPassword: oldPassword, newPassword: newPassword))
            .thenAnswer((_) async => null);

        // act
        final result = await homeRepositoryImpl.updatePassword(
            oldPassword: oldPassword, newPassword: newPassword);

        // assert
        expect(result, equals(const Right(null)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockHomeRemoteDataSource.updatePassword(
                oldPassword: oldPassword, newPassword: newPassword))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result = await homeRepositoryImpl.updatePassword(
            oldPassword: oldPassword, newPassword: newPassword);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockHomeRemoteDataSource.updatePassword(
                oldPassword: oldPassword, newPassword: newPassword))
            .thenThrow(
                const SocketException('Failed to connect to the internet'));

        // act
        final result = await homeRepositoryImpl.updatePassword(
            oldPassword: oldPassword, newPassword: newPassword);

        // assert
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the internet'))));
      },
    );
  });
}
