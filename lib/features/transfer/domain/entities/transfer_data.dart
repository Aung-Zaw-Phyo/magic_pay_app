import 'package:equatable/equatable.dart';

class TransferDataEntity extends Equatable {
  final String fromName;
  final String fromPhone;
  final String toName;
  final String toPhone;
  final int amount;
  final String? description;
  final String hashValue;

  const TransferDataEntity({
    required this.fromName,
    required this.fromPhone,
    required this.toName,
    required this.toPhone,
    required this.amount,
    this.description,
    required this.hashValue,
  });

  @override
  List<Object?> get props => [
        fromName,
        fromPhone,
        toName,
        toPhone,
        amount,
        description,
        hashValue,
      ];
}
