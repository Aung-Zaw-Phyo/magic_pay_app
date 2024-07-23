import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/transaction/data/models/transaction_model.dart';
import 'package:magic_pay_app/features/transaction/data/models/transactions_data_model.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transactions_data.dart';

void main() {
  const testTransactions = [
    TransactionModel(
      trxId: '123',
      amount: "3,000.00 MMK",
      type: 1,
      title: "From Mary",
      dateTime: "2024-07-22 12:56:57",
    ),
    TransactionModel(
      trxId: '456',
      amount: "3,000.00 MMK",
      type: 1,
      title: "From Mary",
      dateTime: "2024-07-22 12:56:57",
    ),
  ];

  const testTransactionsDataModel = TransactionsDataModel(
    currentPage: 1,
    lastPage: 2,
    transactions: testTransactions,
  );

  test(
    'should be a sub class of transactions data entity',
    () {
      expect(testTransactionsDataModel, isA<TransactionsDataEntity>());
    },
  );
}
