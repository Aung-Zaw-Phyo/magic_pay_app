import 'package:magic_pay_app/features/transaction/data/models/transaction_model.dart';
import 'package:magic_pay_app/features/transaction/domain/entities/transactions_data.dart';

class TransactionsDataModel extends TransactionsDataEntity {
  const TransactionsDataModel({
    required int currentPage,
    required int lastPage,
    required List<TransactionModel> transactions,
  }) : super(
            currentPage: currentPage,
            lastPage: lastPage,
            transactions: transactions);
}
