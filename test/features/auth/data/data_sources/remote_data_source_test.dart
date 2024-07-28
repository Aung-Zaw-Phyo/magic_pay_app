import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/features/auth/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/auth/data/models/user.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockDio = MockDio();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockDio);
    mockSharedPreferences = MockSharedPreferences();
  });

  const phone = '0123456';
  const password = 'password';

  group('auth', () {
    group('login', () {
      test('should return token string when response code is 200', () async {
        // arrange
        final mockResponse = dio.Response(
          data: {
            'result': true,
            'message': 'success',
            'data': {'token': 'token string value'},
          },
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: '$baseUrl/login'),
        );

        when(mockDio.post('$baseUrl/login',
                data: {"phone": phone, "password": password}))
            .thenAnswer((_) async => mockResponse);

        // act
        final result = await authRemoteDataSourceImpl.login(
            phone: phone, password: password);

        //assert
        expect(result, isA<String>());
      });

      test(
          'should throw server exception when response code is 422 or other failure code',
          () async {
        // arrange
        final mockResponse = dio.Response(
          data: {
            'result': false,
            'message': 'credentials error',
            'data': null,
          },
          statusCode: 422,
          requestOptions: dio.RequestOptions(path: '$baseUrl/login'),
        );

        when(mockDio.post('$baseUrl/login',
                data: {"phone": phone, "password": password}))
            .thenAnswer((_) async => mockResponse);

        // act
        final result =
            authRemoteDataSourceImpl.login(phone: phone, password: password);

        //assert
        expect(result, throwsA(isA<ServerException>()));
      });
    });

    group('logout', () {
      const token = 'test_token';

      test('should return success response data when response code is 200',
          () async {
        // arrange
        final mockResponse = dio.Response(
          data: {
            'result': true,
            'message': 'success',
            'data': null,
          },
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: '$baseUrl/logout'),
        );

        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
            dio.BaseOptions(headers: {'Authorization': 'Bearer $token'}));
        when(mockDio.post('$baseUrl/logout'))
            .thenAnswer((_) async => mockResponse);

        // act
        final result = await authRemoteDataSourceImpl.logout();

        // assert
        expect(result, isA<Null>());
      });

      test(
          'should throw server exception when response code is 400 or other failure code',
          () async {
        // arrange
        final mockResponse = dio.Response(
          data: {
            'result': false,
            'message': 'bad request',
            'data': null,
          },
          statusCode: 400,
          requestOptions: dio.RequestOptions(path: '$baseUrl/logout'),
        );

        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
            dio.BaseOptions(headers: {'Authorization': 'Bearer $token'}));
        when(mockDio.post('$baseUrl/logout'))
            .thenAnswer((_) async => mockResponse);

        // act
        final result = authRemoteDataSourceImpl.logout();

        // assert
        expect(result, throwsA(isA<ServerException>()));
      });
    });

    group('register', () {
      const testUserModel = UserModel(
        name: 'Tester',
        email: 'tester@gmail.com',
        phone: '123456',
        password: 'password',
      );

      test('should return token string when response code is 201 or 200',
          () async {
        // arrange
        final mockResponse = dio.Response(
          data: {
            'result': true,
            'message': 'success',
            'data': {'token': 'token string value'},
          },
          statusCode: 201,
          requestOptions: dio.RequestOptions(path: '$baseUrl/register'),
        );
        when(mockDio.post('$baseUrl/register', data: testUserModel.toJson()))
            .thenAnswer((_) async => mockResponse);

        // act
        final result = await authRemoteDataSourceImpl.register(testUserModel);

        // assert
        expect(result, isA<String>());
      });

      test(
          'should throw server exception when response code is 422 or other failure code',
          () async {
        // arrange
        final mockResponse = dio.Response(
          data: {
            'result': false,
            'message': 'invalid form data',
            'data': null,
          },
          statusCode: 422,
          requestOptions: dio.RequestOptions(path: '$baseUrl/register'),
        );
        when(mockDio.post('$baseUrl/register', data: testUserModel.toJson()))
            .thenAnswer((_) async => mockResponse);

        // act
        final result = authRemoteDataSourceImpl.register(testUserModel);

        // assert
        expect(result, throwsA(isA<ServerException>()));
      });
    });
  });
}
