import 'package:dio/dio.dart';
import 'package:magic_pay_app/core/constants/constants.dart';
import 'package:magic_pay_app/core/error/exception.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/transaction/data/models/transaction_detail_model.dart';
import 'package:magic_pay_app/features/transaction/data/models/transaction_model.dart';
import 'package:magic_pay_app/features/transaction/data/models/transactions_data_model.dart';

abstract class TransactionRemoteDataSource {
  Future<TransactionsDataModel> getTransactions(int page);
  Future<TransactionDetailModel> getTransactionDetail(String transactionId);
}

class TransactionRemoteDataSourceImpl extends TransactionRemoteDataSource {
  final Dio _dio;

  TransactionRemoteDataSourceImpl(this._dio);

  @override
  Future<TransactionsDataModel> getTransactions(int page) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.get('$baseUrl/transaction?page=$page');
    if (response.statusCode == 200) {
      List<TransactionModel> transactions = response.data['data']
          .map<TransactionModel>((dynamic i) =>
              TransactionModel.fromJson(i as Map<String, dynamic>))
          .toList();

      final transactionsData = TransactionsDataModel(
        currentPage: response.data['meta']['current_page'],
        lastPage: response.data['meta']['last_page'],
        transactions: transactions,
      );

      return transactionsData;
    } else {
      throw ServerException(response.data['message'] ?? 'Something wrong!');
    }
  }

  @override
  Future<TransactionDetailModel> getTransactionDetail(
      String transactionId) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.get('$baseUrl/transaction/$transactionId');
    if (response.statusCode == 200) {
      final transactionDetail = TransactionDetailModel(
        trxId: response.data['data']['trx_id'],
        refNo: response.data['data']['ref_no'],
        amount: response.data['data']['amount'],
        type: response.data['data']['type'],
        dateTime: response.data['data']['date_time'],
        source: response.data['data']['source'],
        description: response.data['data']['description'],
      );

      return transactionDetail;
    } else {
      throw ServerException(response.data['message'] ?? 'Something wrong!');
    }
  }
}
