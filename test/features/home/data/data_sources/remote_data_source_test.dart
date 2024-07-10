import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/response_data.dart';
import 'package:magic_pay_app/features/home/data/data_sources/remote_data_source.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late HomeRemoteDataSourceImpl homeRemoteDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockDio = MockDio();
    homeRemoteDataSourceImpl = HomeRemoteDataSourceImpl(mockDio);
    mockSharedPreferences = MockSharedPreferences();
  });

  const token = 'test_token';

  group('profile', () {
    test(
      'should return success response data when response code is 200',
      () async {
        // arrange
        const responseData = ResponseData(
          result: true,
          message: 'success',
          data: 'profile data',
        );
        final mockResponse = dio.Response(
          data: responseData.toJson(),
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: '$baseUrl/profile'),
        );
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
            dio.BaseOptions(headers: {'Authorization': 'Bearer $token'}));
        when(mockDio.get('$baseUrl/profile'))
            .thenAnswer((_) async => mockResponse);

        // act
        final result = await homeRemoteDataSourceImpl.getProfile();

        // assert
        expect(result, equals(responseData));
        expect(result, isA<ResponseData>());
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        final mockResponse = dio.Response(
          data: {
            'result': false,
            'message': 'error',
            'data': null,
          },
          statusCode: 500,
          requestOptions: dio.RequestOptions(path: '$baseUrl/profile'),
        );
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
            dio.BaseOptions(headers: {'Authorization': 'Bearer $token'}));
        when(mockDio.get('$baseUrl/profile'))
            .thenAnswer((_) async => mockResponse);

        // act
        final result = homeRemoteDataSourceImpl.getProfile();

        // assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });

  group('update password', () {
    test(
      'should return success response data when response code is 200',
      () async {
        // arrange
        const responseData = ResponseData(
          result: true,
          message: 'success',
          data: 'data',
        );
        final mockResponse = dio.Response(
          data: responseData.toJson(),
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: '$baseUrl/update-password'),
        );
        const oldPassword = 'password-old';
        const newPassword = 'password-new';
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
            dio.BaseOptions(headers: {'Authorization': 'Bearer $token'}));
        when(mockDio.post(
          '$baseUrl/update-password',
          data: {'old_password': oldPassword, 'new_password': newPassword},
        )).thenAnswer((_) async => mockResponse);

        // act
        final result = await homeRemoteDataSourceImpl.updatePassword(
            oldPassword: oldPassword, newPassword: newPassword);

        // assert
        expect(result, equals(responseData));
        expect(result, isA<ResponseData>());
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        final mockResponse = dio.Response(
          data: {
            'result': false,
            'message': 'error',
            'data': null,
          },
          statusCode: 500,
          requestOptions: dio.RequestOptions(path: '$baseUrl/update-password'),
        );
        const oldPassword = 'password-old';
        const newPassword = 'password-new';
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
            dio.BaseOptions(headers: {'Authorization': 'Bearer $token'}));
        when(mockDio.post(
          '$baseUrl/update-password',
          data: {'old_password': oldPassword, 'new_password': newPassword},
        )).thenAnswer((_) async => mockResponse);

        // act
        final result = homeRemoteDataSourceImpl.updatePassword(
            oldPassword: oldPassword, newPassword: newPassword);

        // assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
