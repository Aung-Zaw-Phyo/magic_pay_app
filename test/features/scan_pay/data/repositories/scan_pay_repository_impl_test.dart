import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_data_model.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_form_data_model.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_request_model.dart';
import 'package:magic_pay_app/features/scan_pay/data/repositories/scan_pay_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockScanPayRemoteDataSource mockScanPayRemoteDataSource;
  late ScanPayRepositoryImpl scanPayRepositoryImpl;

  setUp(() {
    mockScanPayRemoteDataSource = MockScanPayRemoteDataSource();
    scanPayRepositoryImpl = ScanPayRepositoryImpl(mockScanPayRemoteDataSource);
  });

  const toPhone = '09968548025';

  const testScanPayFormDataModel = ScanPayFormDataModel(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '09968548024',
    toName: 'Mary',
    toPhone: toPhone,
  );

  const testScanPayDataModel = ScanPayDataModel(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '09968548024',
    toName: 'Mary',
    toPhone: toPhone,
    amount: 3000,
    description: 'description',
    hashValue: 'hashValue',
  );

  const testScanPayRequestModel = ScanPayRequestModel(
    toPhone: toPhone,
    amount: 3000,
    hashValue: 'hashValue',
    description: 'description',
    password: 'password',
  );

  const trxId = '234234234';

  group('scan qr code', () {
    test(
      'should return scanpay form data when a call to data source is successful',
      () async {
        // arrange
        when(mockScanPayRemoteDataSource.scanQrCode(toPhone))
            .thenAnswer((_) async => testScanPayFormDataModel);

        // act
        final result = await scanPayRepositoryImpl.scanQrCode(toPhone);

        // assert
        expect(result, equals(const Right(testScanPayFormDataModel)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockScanPayRemoteDataSource.scanQrCode(toPhone))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result = await scanPayRepositoryImpl.scanQrCode(toPhone);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockScanPayRemoteDataSource.scanQrCode(toPhone)).thenThrow(
            const SocketException('Failed to connect to the internet'));

        // act
        final result = await scanPayRepositoryImpl.scanQrCode(toPhone);

        // assert
        expect(
          result,
          equals(
            const Left(
              ConnectionFailure('Failed to connect to the internet'),
            ),
          ),
        );
      },
    );
  });

  group('pay confirm', () {
    test(
      'should return scanpay data when a call to data source is successful',
      () async {
        // arrange
        when(mockScanPayRemoteDataSource.payConfirm(testScanPayRequestModel))
            .thenAnswer((_) async => testScanPayDataModel);

        // act
        final result =
            await scanPayRepositoryImpl.payConfirm(testScanPayRequestModel);

        // assert
        expect(result, equals(const Right(testScanPayDataModel)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockScanPayRemoteDataSource.payConfirm(testScanPayRequestModel))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result =
            await scanPayRepositoryImpl.payConfirm(testScanPayRequestModel);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockScanPayRemoteDataSource.payConfirm(testScanPayRequestModel))
            .thenThrow(
                const SocketException('Failed to connect to the internet'));

        // act
        final result =
            await scanPayRepositoryImpl.payConfirm(testScanPayRequestModel);

        // assert
        expect(
          result,
          equals(
            const Left(
              ConnectionFailure('Failed to connect to the internet'),
            ),
          ),
        );
      },
    );
  });

  group('pay complete', () {
    test(
      'should return trxId string when a call to data source is successful',
      () async {
        // arrange
        when(mockScanPayRemoteDataSource.payComplete(testScanPayRequestModel))
            .thenAnswer((_) async => trxId);

        // act
        final result =
            await scanPayRepositoryImpl.payComplete(testScanPayRequestModel);

        // assert
        expect(result, equals(const Right(trxId)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockScanPayRemoteDataSource.payComplete(testScanPayRequestModel))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result =
            await scanPayRepositoryImpl.payComplete(testScanPayRequestModel);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockScanPayRemoteDataSource.payComplete(testScanPayRequestModel))
            .thenThrow(
                const SocketException('Failed to connect to the internet'));

        // act
        final result =
            await scanPayRepositoryImpl.payComplete(testScanPayRequestModel);

        // assert
        expect(
          result,
          equals(
            const Left(
              ConnectionFailure('Failed to connect to the internet'),
            ),
          ),
        );
      },
    );
  });
}
