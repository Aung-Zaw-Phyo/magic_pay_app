import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String trxId;
  final String amount;
  final int type;
  final String title;
  final String dateTime;

  const TransactionEntity({
    required this.trxId,
    required this.amount,
    required this.type,
    required this.title,
    required this.dateTime,
  });

  @override
  List<Object> get props => [trxId, amount, type, title, dateTime];
}
