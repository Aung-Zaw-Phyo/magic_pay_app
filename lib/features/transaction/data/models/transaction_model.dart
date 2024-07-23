import 'package:magic_pay_app/features/transaction/domain/entities/transaction.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required String trxId,
    required String amount,
    required int type,
    required String title,
    required String dateTime,
  }) : super(
          trxId: trxId,
          amount: amount,
          type: type,
          title: title,
          dateTime: dateTime,
        );

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        trxId: json['trx_id'],
        amount: json['amount'],
        type: json['type'],
        title: json['title'],
        dateTime: json['date_time'],
      );

  Map<String, dynamic> toJson() => {
        'trx_id': trxId,
        'amount': amount,
        'type': type,
        'title': title,
        'date_time': dateTime,
      };
}
