import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/transaction/data/models/transaction_model.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transaction.dart';

void main() {
  const testTransactionModel = TransactionModel(
    trxId: '123',
    amount: "3,000.00 MMK",
    type: 1,
    title: "From Mary",
    dateTime: "2024-07-22 12:56:57",
  );

  const jsonMap = {
    "trx_id": "123",
    "amount": "3,000.00 MMK",
    "type": 1,
    "title": "From Mary",
    "date_time": "2024-07-22 12:56:57",
  };

  group('transaction', () {
    test('should be a sub class of transaction entity', () {
      expect(testTransactionModel, isA<TransactionEntity>());
    });

    test("should return a valid model from json", () {
      // act
      final result = TransactionModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testTransactionModel));
    });

    test("should return a json map containing proper data", () {
      // act
      final result = testTransactionModel.toJson();

      // assert
      expect(result, equals(jsonMap));
    });
  });
}
