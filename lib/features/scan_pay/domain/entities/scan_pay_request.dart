import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/transfer/data/models/transfer_request_model.dart';

class ScanPayRequestEntity extends Equatable {
  final String toPhone;
  final int amount;
  final String hashValue;
  final String? description;
  final String? password;

  const ScanPayRequestEntity({
    required this.toPhone,
    required this.amount,
    required this.hashValue,
    this.description,
    this.password,
  });

  TransferRequestModel toModel() => TransferRequestModel(
        toPhone: toPhone,
        amount: amount,
        hashValue: hashValue,
        description: description,
        password: password,
      );

  @override
  List<Object?> get props => [
        toPhone,
        amount,
        hashValue,
        description,
        password,
      ];
}
