import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/features/scan_pay/data/datasources/remote_data_source.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_data_model.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_form_data_model.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_request_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;
  late ScanPayRemoteDataSourceImpl scanPayRemoteDataSourceImpl;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();
    scanPayRemoteDataSourceImpl = ScanPayRemoteDataSourceImpl(mockDio);
  });

  const toPhone = '09968548025';
  const token = 'test_token';
  const trxId = '234234234';

  const testScanPayRequestModel = ScanPayRequestModel(
    toPhone: toPhone,
    amount: 3000,
    hashValue: 'hashValue',
    description: 'description',
    password: 'password',
  );

  const formJsonMap = {
    'from_name': 'Aung Zaw Phyo',
    'from_phone': '09968548024',
    'to_name': 'Mary',
    'to_phone': toPhone,
  };
  const jsonMap = {
    'from_name': 'Aung Zaw Phyo',
    'from_phone': '09968548024',
    'to_name': 'Mary',
    'to_phone': toPhone,
    'amount': 3000,
    'description': 'description',
    'hash_value': 'hashValue',
  };

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

  group('scan qr code', () {
    test(
      'should return scanpay form data when response code is 200',
      () async {
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(dio.BaseOptions(
          headers: {'Authorization': 'Bearer $token'},
        ));

        final mockResponse = dio.Response(
          data: {
            'result': true,
            'message': 'success',
            'data': formJsonMap,
          },
          statusCode: 200,
          requestOptions:
              dio.RequestOptions(path: '$baseUrl/scan-and-pay-form'),
        );
        when(mockDio.post('$baseUrl/scan-and-pay-form',
            data: {"to_phone": toPhone})).thenAnswer((_) async => mockResponse);

        final result = await scanPayRemoteDataSourceImpl.scanQrCode(toPhone);

        expect(result, isA<ScanPayFormDataModel>());
        expect(result, equals(testScanPayFormDataModel));
      },
    );

    test(
      'should throw server exception when response code is 422 or other failure code',
      () async {
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(dio.BaseOptions(
          headers: {'Authorization': 'Bearer $token'},
        ));

        final mockResponse = dio.Response(
          data: {
            'result': false,
            'message': 'validation error',
            'data': null,
          },
          statusCode: 422,
          requestOptions:
              dio.RequestOptions(path: '$baseUrl/scan-and-pay-form'),
        );
        when(mockDio.post('$baseUrl/scan-and-pay-form',
            data: {"to_phone": toPhone})).thenAnswer((_) async => mockResponse);

        final result = scanPayRemoteDataSourceImpl.scanQrCode(toPhone);

        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });

  group('pay confirm', () {
    test(
      'should return scanpay data when response code is 200',
      () async {
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(dio.BaseOptions(
          headers: {'Authorization': 'Bearer $token'},
        ));

        final mockResponse = dio.Response(
          data: {
            'result': true,
            'message': 'success',
            'data': jsonMap,
          },
          statusCode: 200,
          requestOptions:
              dio.RequestOptions(path: '$baseUrl/scan-and-pay-confirm'),
        );
        when(mockDio.post('$baseUrl/scan-and-pay-confirm',
                data: testScanPayRequestModel.toJson()))
            .thenAnswer((_) async => mockResponse);

        final result = await scanPayRemoteDataSourceImpl
            .payConfirm(testScanPayRequestModel);

        expect(result, isA<ScanPayDataModel>());
        expect(result, equals(testScanPayDataModel));
      },
    );

    test(
      'should throw server exception when response code is 422 or other failure code',
      () async {
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(dio.BaseOptions(
          headers: {'Authorization': 'Bearer $token'},
        ));

        final mockResponse = dio.Response(
          data: {
            'result': false,
            'message': 'validation error',
            'data': null,
          },
          statusCode: 422,
          requestOptions:
              dio.RequestOptions(path: '$baseUrl/scan-and-pay-confirm'),
        );
        when(mockDio.post('$baseUrl/scan-and-pay-confirm',
                data: testScanPayRequestModel.toJson()))
            .thenAnswer((_) async => mockResponse);

        final result =
            scanPayRemoteDataSourceImpl.payConfirm(testScanPayRequestModel);

        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });

  group('pay complete', () {
    test(
      'should return trxId string when response code is 200',
      () async {
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(dio.BaseOptions(
          headers: {'Authorization': 'Bearer $token'},
        ));

        final mockResponse = dio.Response(
          data: {
            'result': true,
            'message': 'success',
            'data': {'trx_id': trxId},
          },
          statusCode: 200,
          requestOptions:
              dio.RequestOptions(path: '$baseUrl/scan-and-pay-complete'),
        );
        when(mockDio.post('$baseUrl/scan-and-pay-complete',
                data: testScanPayRequestModel.toJson()))
            .thenAnswer((_) async => mockResponse);

        final result = await scanPayRemoteDataSourceImpl
            .payComplete(testScanPayRequestModel);

        expect(result, isA<String>());
        expect(result, equals(trxId));
      },
    );

    test(
      'should throw server exception when response code is 422 or other failure code',
      () async {
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(dio.BaseOptions(
          headers: {'Authorization': 'Bearer $token'},
        ));

        final mockResponse = dio.Response(
          data: {
            'result': false,
            'message': 'validation error',
            'data': null,
          },
          statusCode: 422,
          requestOptions:
              dio.RequestOptions(path: '$baseUrl/scan-and-pay-complete'),
        );
        when(mockDio.post('$baseUrl/scan-and-pay-complete',
                data: testScanPayRequestModel.toJson()))
            .thenAnswer((_) async => mockResponse);

        final result =
            scanPayRemoteDataSourceImpl.payComplete(testScanPayRequestModel);

        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
