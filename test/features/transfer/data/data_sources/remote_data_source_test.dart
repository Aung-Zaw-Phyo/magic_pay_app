import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/features/transfer/data/models/transfer_data_model.dart';
import 'package:magic_pay_app/features/transfer/data/models/transfer_request_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;
import 'package:magic_pay_app/features/transfer/data/data_sources/remote_data_source.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late TransferRemoteDataSourceImpl transferRemoteDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockDio = MockDio();
    transferRemoteDataSourceImpl = TransferRemoteDataSourceImpl(mockDio);
    mockSharedPreferences = MockSharedPreferences();
    SharedPreferences.setMockInitialValues({});
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

  const jsonMap = {
    'from_name': 'Aung Zaw Phyo',
    'from_phone': '09968548024',
    'to_name': 'Mary',
    'to_phone': '09968548025',
    'amount': 3000,
    'description': 'description',
    'hash_value': 'hashValue',
  };

  const testTransferRequestModel = TransferRequestModel(
    toPhone: '09968548025',
    amount: 3000,
    hashValue: 'hashValue',
    description: 'description',
    password: 'password',
  );

  const transactionId = '234234234';

  const token = 'test_token';

  group('transfer confirm', () {
    test(
      'should return transfer data when response code is 200',
      () async {
        // arrange
        final mockResponse = dio.Response(
          data: {
            'result': true,
            'message': 'success',
            'data': jsonMap,
          },
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: '$baseUrl/transfer/confirm'),
        );

        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
          dio.BaseOptions(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        when(mockDio.post('$baseUrl/transfer/confirm',
                data: testTransferRequestModel.toJson()))
            .thenAnswer((_) async => mockResponse);

        // act
        final result = await transferRemoteDataSourceImpl
            .transferConfirm(testTransferRequestModel);

        //assert
        expect(result, isA<TransferDataModel>());
        expect(result, equals(testTransferDataModel));
      },
    );

    test(
        'should throw server exception when response code is 422 or other failure code',
        () async {
      // arrange
      final mockResponse = dio.Response(
        data: {
          'result': false,
          'message': 'validation error',
          'data': null,
        },
        statusCode: 422,
        requestOptions: dio.RequestOptions(path: '$baseUrl/transfer/confirm'),
      );

      when(mockSharedPreferences.getString('token')).thenReturn(token);
      when(mockDio.options).thenReturn(
        dio.BaseOptions(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      when(mockDio.post('$baseUrl/transfer/confirm',
              data: testTransferRequestModel.toJson()))
          .thenAnswer((_) async => mockResponse);

      // act
      final result = transferRemoteDataSourceImpl
          .transferConfirm(testTransferRequestModel);

      //assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('transfer complete', () {
    test(
      'should return transaction id string when response code is 200',
      () async {
        // arrange
        final mockResponse = dio.Response(
          data: {
            'result': true,
            'message': 'success',
            'data': {'trx_id': transactionId},
          },
          statusCode: 200,
          requestOptions:
              dio.RequestOptions(path: '$baseUrl/transfer/complete'),
        );

        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
          dio.BaseOptions(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        when(mockDio.post('$baseUrl/transfer/complete',
                data: testTransferRequestModel.toJson()))
            .thenAnswer((_) async => mockResponse);

        // act
        final result = await transferRemoteDataSourceImpl
            .transferComplete(testTransferRequestModel);

        //assert
        expect(result, isA<String>());
        expect(result, equals(transactionId));
      },
    );

    test(
        'should throw server exception when response code is 422 or other failure code',
        () async {
      // arrange
      final mockResponse = dio.Response(
        data: {
          'result': false,
          'message': 'validation error',
          'data': null,
        },
        statusCode: 422,
        requestOptions: dio.RequestOptions(path: '$baseUrl/transfer/complete'),
      );

      when(mockSharedPreferences.getString('token')).thenReturn(token);
      when(mockDio.options).thenReturn(
        dio.BaseOptions(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      when(mockDio.post('$baseUrl/transfer/complete',
              data: testTransferRequestModel.toJson()))
          .thenAnswer((_) async => mockResponse);

      // act
      final result = transferRemoteDataSourceImpl
          .transferComplete(testTransferRequestModel);

      //assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
