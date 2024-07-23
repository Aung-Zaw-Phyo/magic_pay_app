import 'package:dio/dio.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_data_model.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_detail_model.dart';
import 'package:magic_pay_app/features/notification/data/models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<NotificationDataModel> getNotifications(int page);
  Future<NotificationDetailModel> getNotificationDetail(String notificationId);
}

class NotificationRemoteDataSourceImpl extends NotificationRemoteDataSource {
  final Dio _dio;

  NotificationRemoteDataSourceImpl(this._dio);

  @override
  Future<NotificationDataModel> getNotifications(int page) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.get('$baseUrl/notification?page=$page');
    if (response.statusCode == 200) {
      List<NotificationModel> notifications = response.data['data']
          .map<NotificationModel>((dynamic i) =>
              NotificationModel.fromJson(i as Map<String, dynamic>))
          .toList();

      final notificationData = NotificationDataModel(
        currentPage: response.data['meta']['current_page'],
        lastPage: response.data['meta']['last_page'],
        notifications: notifications,
      );

      return notificationData;
    } else {
      throw ServerException(response.data['message'] ?? 'Something wrong!');
    }
  }

  @override
  Future<NotificationDetailModel> getNotificationDetail(
      String notificationId) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.get('$baseUrl/notification/$notificationId');
    if (response.statusCode == 200) {
      final param = response.data['data']['deep_link']['parameter'];
      final notificationDetail = NotificationDetailModel(
        title: response.data['data']['title'],
        message: response.data['data']['message'],
        dateTime: response.data['data']['date_time'],
        deepLink: DeepLinkModel(
          target: response.data['data']['deep_link']['target'],
          parameter: param != null ? param['trx_id'] : null,
        ),
      );

      return notificationDetail;
    } else {
      throw ServerException(response.data['message'] ?? 'Something wrong!');
    }
  }
}
