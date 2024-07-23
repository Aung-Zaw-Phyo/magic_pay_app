import 'package:equatable/equatable.dart';

class TransactionDetailEntity extends Equatable {
  final String trxId;
  final String refNo;
  final String amount;
  final int type;
  final String dateTime;
  final String source;
  final String description;

  const TransactionDetailEntity({
    required this.trxId,
    required this.refNo,
    required this.amount,
    required this.type,
    required this.dateTime,
    required this.source,
    required this.description,
  });

  @override
  List<Object> get props => [
        trxId,
        refNo,
        amount,
        type,
        dateTime,
        source,
        description,
      ];
}
