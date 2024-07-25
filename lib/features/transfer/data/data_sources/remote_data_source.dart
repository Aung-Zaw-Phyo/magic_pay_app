import 'package:dio/dio.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/transfer/data/models/transfer_data_model.dart';
import 'package:magic_pay_app/features/transfer/data/models/transfer_request_model.dart';

abstract class TransferRemoteDataSource {
  Future<TransferDataModel> transferConfirm(
      TransferRequestModel transferRequestModel);
  Future<String> transferComplete(TransferRequestModel transferRequestModel);
}

class TransferRemoteDataSourceImpl extends TransferRemoteDataSource {
  final Dio _dio;

  TransferRemoteDataSourceImpl(this._dio);

  @override
  Future<TransferDataModel> transferConfirm(
      TransferRequestModel transferRequestModel) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.post(
      '$baseUrl/transfer/confirm',
      data: transferRequestModel.toJson(),
    );
    if (response.statusCode == 200) {
      final transferData = TransferDataModel.fromJson(response.data['data']);
      return transferData;
    } else {
      throw ServerException(response.data['message'] ?? 'Something wrong!');
    }
  }

  @override
  Future<String> transferComplete(
      TransferRequestModel transferRequestModel) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.post(
      '$baseUrl/transfer/complete',
      data: transferRequestModel.toJson(),
    );
    if (response.statusCode == 200) {
      final trxId = response.data['data']['trx_id'];
      return trxId.toString();
    } else {
      throw ServerException(response.data['message'] ?? 'Something wrong!');
    }
  }
}
