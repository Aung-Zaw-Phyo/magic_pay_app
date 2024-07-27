import 'package:dio/dio.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_data_model.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_form_data_model.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_request_model.dart';

abstract class ScanPayRemoteDataSource {
  Future<ScanPayFormDataModel> scanQrCode(String toPhone);
  Future<ScanPayDataModel> payConfirm(ScanPayRequestModel scanPayRequestModel);
  Future<String> payComplete(ScanPayRequestModel scanPayRequestModel);
}

class ScanPayRemoteDataSourceImpl extends ScanPayRemoteDataSource {
  final Dio _dio;

  ScanPayRemoteDataSourceImpl(this._dio);

  @override
  Future<ScanPayFormDataModel> scanQrCode(String toPhone) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.get(
      '$baseUrl/scan-and-pay-form',
      data: {"to_phone": toPhone},
    );
    if (response.statusCode == 200) {
      final data = ScanPayFormDataModel.fromJson(response.data['data']);
      return data;
    } else {
      throw ServerException(response.data['message'] ?? 'Something wrong!');
    }
  }

  @override
  Future<ScanPayDataModel> payConfirm(
      ScanPayRequestModel scanPayRequestModel) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.post(
      '$baseUrl/scan-and-pay-confirm',
      data: scanPayRequestModel.toJson(),
    );
    if (response.statusCode == 200) {
      final data = ScanPayDataModel.fromJson(response.data['data']);
      return data;
    } else {
      throw ServerException(response.data['message'] ?? 'Something wrong!');
    }
  }

  @override
  Future<String> payComplete(ScanPayRequestModel scanPayRequestModel) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.post(
      '$baseUrl/scan-and-pay-complete',
      data: scanPayRequestModel.toJson(),
    );
    if (response.statusCode == 200) {
      final trxId = response.data['data']['trx_id'];
      return trxId.toString();
    } else {
      throw ServerException(response.data['message'] ?? 'Something wrong!');
    }
  }
}
