import 'package:magic_pay_app/features/transaction/domain/entities/transaction_detail.dart';

class TransactionDetailModel extends TransactionDetailEntity {
  const TransactionDetailModel({
    required String trxId,
    required String refNo,
    required String amount,
    required int type,
    required String dateTime,
    required String source,
    required String description,
  }) : super(
          trxId: trxId,
          refNo: refNo,
          amount: amount,
          type: type,
          dateTime: dateTime,
          source: source,
          description: description,
        );

  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) =>
      TransactionDetailModel(
        trxId: json['trx_id'],
        refNo: json['ref_no'],
        amount: json['amount'],
        type: json['type'],
        dateTime: json['date_time'],
        source: json['source'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'trx_id': trxId,
        'ref_no': refNo,
        'amount': amount,
        'type': type,
        'date_time': dateTime,
        'source': source,
        'description': description,
      };
}
