import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_data_model.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_detail_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;
import 'package:magic_pay_app/features/notification/data/data_sources/remote_data_source.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;
  late NotificationRemoteDataSourceImpl notificationRemoteDataSourceImpl;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();
    notificationRemoteDataSourceImpl =
        NotificationRemoteDataSourceImpl(mockDio);
  });

  const token = 'test_token';
  const notificationsResponseData = {
    "data": [
      {
        "id": "123",
        "title": "Password Updated",
        "message": "Your password updated successfully!",
        "date_time": "2024-07-09 02:07:40 PM",
        "read": 0
      },
      {
        "id": "456",
        "title": "Password Updated",
        "message": "Your password updated successfully!",
        "date_time": "2024-07-09 02:07:40 PM",
        "read": 0
      },
    ],
    "meta": {
      "current_page": 1,
      "last_page": 3,
    },
    "result": 1,
    "message": "success"
  };

  const notificationDetailResponseData = {
    "result": true,
    "message": "success",
    "data": {
      "title": "Password Updated",
      "message": "Your password updated successfully!",
      "web_link": "http://localhost:8000/profile",
      "date_time": "2024-07-09 02:07:40 PM",
      "deep_link": {"target": "profile", "parameter": null}
    }
  };

  const errorResponseData = {
    'result': false,
    'message': 'error',
    'data': null,
  };

  const pageNumber = 1;

  group('notifications', () {
    test(
      'should return notification data model when response code is 200',
      () async {
        final mockResponse = dio.Response(
          data: notificationsResponseData,
          statusCode: 200,
          requestOptions: dio.RequestOptions(
              path: '$baseUrl/notification?page=$pageNumber'),
        );
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
          dio.BaseOptions(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        when(mockDio.get('$baseUrl/notification?page=$pageNumber'))
            .thenAnswer((_) async => mockResponse);

        final result =
            await notificationRemoteDataSourceImpl.getNotifications(1);

        expect(result, isA<NotificationDataModel>());
      },
    );

    test(
      'should throw a server exception when the response code is 500 or other',
      () async {
        final mockResponse = dio.Response(
          data: errorResponseData,
          statusCode: 500,
          requestOptions: dio.RequestOptions(
              path: '$baseUrl/notification?page=$pageNumber'),
        );
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
          dio.BaseOptions(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        when(mockDio.get('$baseUrl/notification?page=$pageNumber'))
            .thenAnswer((_) async => mockResponse);

        final result = notificationRemoteDataSourceImpl.getNotifications(1);

        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });

  group('notification detail', () {
    test(
      'should return notification detail model when response code is 200',
      () async {
        final mockResponse = dio.Response(
          data: notificationDetailResponseData,
          statusCode: 200,
          requestOptions: dio.RequestOptions(path: '$baseUrl/notification/123'),
        );
        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
          dio.BaseOptions(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        when(mockDio.get('$baseUrl/notification/123'))
            .thenAnswer((_) async => mockResponse);

        final result =
            await notificationRemoteDataSourceImpl.getNotificationDetail('123');

        expect(result, isA<NotificationDetailModel>());
      },
    );

    test(
      'should throw a server exception when the response code is 500 or other',
      () async {
        final mockResponse = dio.Response(
          data: errorResponseData,
          statusCode: 500,
          requestOptions: dio.RequestOptions(path: '$baseUrl/notification/123'),
        );

        when(mockSharedPreferences.getString('token')).thenReturn(token);
        when(mockDio.options).thenReturn(
          dio.BaseOptions(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        when(mockDio.get('$baseUrl/notification/123'))
            .thenAnswer((_) async => mockResponse);

        final result =
            notificationRemoteDataSourceImpl.getNotificationDetail('123');

        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
