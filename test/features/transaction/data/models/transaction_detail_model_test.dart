import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/transaction/data/models/transaction_detail_model.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction_detail.dart';

void main() {
  const transactionId = '4549612618172021';
  const testTransactionDetailModel = TransactionDetailModel(
    trxId: transactionId,
    refNo: '2165214577780755',
    amount: '3,000.00 MMK',
    type: 1,
    dateTime: '2024-07-22 12:56:57',
    source: 'Mary',
    description: 'Class Fee',
  );

  const jsonMap = {
    'trx_id': transactionId,
    'ref_no': '2165214577780755',
    'amount': '3,000.00 MMK',
    'type': 1,
    'date_time': '2024-07-22 12:56:57',
    'source': 'Mary',
    'description': 'Class Fee',
  };

  group('transaction detail', () {
    test('should be a sub class of transaction detail entity', () {
      expect(testTransactionDetailModel, isA<TransactionDetailEntity>());
    });

    test("should return a valid model from json", () {
      // act
      final result = TransactionDetailModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testTransactionDetailModel));
    });

    test("should return a json map containing proper data", () {
      // act
      final result = testTransactionDetailModel.toJson();

      // assert
      expect(result, equals(jsonMap));
    });
  });
}
