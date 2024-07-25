import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';

class TransferRequestModel extends TransferRequestEntity {
  const TransferRequestModel({
    required String toPhone,
    required int amount,
    required String hashValue,
    String? description,
    String? password,
  }) : super(
          toPhone: toPhone,
          amount: amount,
          hashValue: hashValue,
          description: description,
          password: password,
        );

  factory TransferRequestModel.fromJson(Map<String, dynamic> json) =>
      TransferRequestModel(
        toPhone: json['to_phone'],
        amount: json['amount'],
        hashValue: json['hash_value'],
        description: json['description'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'to_phone': toPhone,
        'amount': amount,
        'hash_value': hashValue,
        'description': description,
        'password': password,
      };
}
