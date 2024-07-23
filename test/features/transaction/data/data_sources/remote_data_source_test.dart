import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart' as dio;
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/features/transaction/data/models/transaction_detail_model.dart';
import 'package:magic_pay_app/features/transaction/data/models/transactions_data_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:magic_pay_app/features/transaction/data/data_sources/remote_data_source.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;
  late TransactionRemoteDataSourceImpl transactionRemoteDataSourceImpl;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();
    transactionRemoteDataSourceImpl = TransactionRemoteDataSourceImpl(mockDio);
  });

  const token = 'test_token';
  const transactionsResponseData = {
    "data": [
      {
        "trx_id": "4549612618172021",
        "amount": "3,000.00 MMK",
        "type": 1,
        "title": "From Linn Khit",
        "date_time": "2024-07-22 12:56:57"
      },
      {
        "trx_id": "4549612618172022",
        "amount": "3,000.00 MMK",
        "type": 1,
        "title": "From Linn Khit",
        "date_time": "2024-07-22 12:56:57"
      },
    ],
    "meta": {
      "current_page": 1,
      "last_page": 3,
    },
    "result": 1,
    "message": "success"
  };

  const transactionId = '4549612618172021';
  const transactionDetailResponseData = {
    "result": true,
    "message": "success",
    "data": {
      "trx_id": transactionId,
      "ref_no": "2165214577780755",
      "amount": "3,000.00 MMK",
      "type": 1,
      "date_time": "2024-07-22 12:56:57",
      "source": "Linn Khit",
      "description": "Class Fee",
    }
  };

  const errorResponseData = {
    'result': false,
    'message': 'error',
    'data': null,
  };

  const pageNumber = 1;

  group('transactions', () {
    test(
      'should return transactions data model when response code is 200',
      () async {
        final mockResponse = dio.Response(
          data: transactionsResponseData,
          statusCode: 200,
          requestOptions:
              dio.RequestOptions(path: '$baseUrl/transaction?page=$pageNumber'),
        );
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
          dio.BaseOptions(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        when(mockDio.get('$baseUrl/transaction?page=$pageNumber'))
            .thenAnswer((_) async => mockResponse);

        final result =
            await transactionRemoteDataSourceImpl.getTransactions(pageNumber);

        expect(result, isA<TransactionsDataModel>());
      },
    );

    test(
      'should throw a server exception when the response code is 500 or other',
      () async {
        final mockResponse = dio.Response(
          data: errorResponseData,
          statusCode: 500,
          requestOptions:
              dio.RequestOptions(path: '$baseUrl/transaction?page=$pageNumber'),
        );
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
          dio.BaseOptions(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        when(mockDio.get('$baseUrl/transaction?page=$pageNumber'))
            .thenAnswer((_) async => mockResponse);

        final result =
            transactionRemoteDataSourceImpl.getTransactions(pageNumber);

        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });

  group('transaction detail', () {
    test(
      'should return transaction detail model when response code is 200',
      () async {
        final mockResponse = dio.Response(
          data: transactionDetailResponseData,
          statusCode: 200,
          requestOptions:
              dio.RequestOptions(path: '$baseUrl/transactions/$transactionId'),
        );
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
          dio.BaseOptions(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        when(mockDio.get('$baseUrl/transaction/$transactionId'))
            .thenAnswer((_) async => mockResponse);

        final result = await transactionRemoteDataSourceImpl
            .getTransactionDetail(transactionId);

        expect(result, isA<TransactionDetailModel>());
      },
    );

    test(
      'should throw a server exception when the response code is 500 or other',
      () async {
        final mockResponse = dio.Response(
          data: errorResponseData,
          statusCode: 500,
          requestOptions:
              dio.RequestOptions(path: '$baseUrl/transaction/$transactionId'),
        );

        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
          dio.BaseOptions(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        when(mockDio.get('$baseUrl/transaction/$transactionId'))
            .thenAnswer((_) async => mockResponse);

        final result =
            transactionRemoteDataSourceImpl.getTransactionDetail(transactionId);

        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
