import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/error/failure.dart';
import 'package:magic_pay_app/features/transfer/data/models/transfer_data_model.dart';
import 'package:magic_pay_app/features/transfer/data/models/transfer_request_model.dart';
import 'package:magic_pay_app/features/transfer/data/repositories/transfer_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTransferRemoteDataSource mockTransferRemoteDataSource;
  late TransferRepositoryImpl transferRepositoryImpl;

  setUp(() {
    mockTransferRemoteDataSource = MockTransferRemoteDataSource();
    transferRepositoryImpl =
        TransferRepositoryImpl(mockTransferRemoteDataSource);
  });

  const testTransferDataModel = TransferDataModel(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '09968548024',
    toName: 'Mary',
    toPhone: '09968548025',
    amount: 3000,
    description: 'description',
    hashValue: 'hashValue',
  );

  const testTransferRequestModel = TransferRequestModel(
    toPhone: '09968548025',
    amount: 3000,
    hashValue: 'hashValue',
    description: 'description',
    password: 'password',
  );

  const transactionId = '234234234';

  group('transfer confirm', () {
    test(
      'should return transfer data when a call to data source is successful',
      () async {
        // arrange
        when(mockTransferRemoteDataSource
                .transferConfirm(testTransferRequestModel))
            .thenAnswer((_) async => testTransferDataModel);

        // act
        final result = await transferRepositoryImpl
            .transferConfirm(testTransferRequestModel);

        // assert
        expect(result, equals(const Right(testTransferDataModel)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockTransferRemoteDataSource
                .transferConfirm(testTransferRequestModel))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result = await transferRepositoryImpl
            .transferConfirm(testTransferRequestModel);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockTransferRemoteDataSource
                .transferConfirm(testTransferRequestModel))
            .thenThrow(
                const SocketException('Failed to connect to the internet'));

        // act
        final result = await transferRepositoryImpl
            .transferConfirm(testTransferRequestModel);

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

  group('transfer complete', () {
    test(
      'should return transaction id string when a call to data source is successful',
      () async {
        // arrange
        when(mockTransferRemoteDataSource
                .transferComplete(testTransferRequestModel))
            .thenAnswer((_) async => transactionId);

        // act
        final result = await transferRepositoryImpl
            .transferComplete(testTransferRequestModel);

        // assert
        expect(result, equals(const Right(transactionId)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockTransferRemoteDataSource
                .transferComplete(testTransferRequestModel))
            .thenThrow(const ServerException('An error has occured'));

        // act
        final result = await transferRepositoryImpl
            .transferComplete(testTransferRequestModel);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occured'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockTransferRemoteDataSource
                .transferComplete(testTransferRequestModel))
            .thenThrow(
                const SocketException('Failed to connect to the internet'));

        // act
        final result = await transferRepositoryImpl
            .transferComplete(testTransferRequestModel);

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
