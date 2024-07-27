import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';

class ScanPayRequestModel extends ScanPayRequestEntity {
  const ScanPayRequestModel({
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

  factory ScanPayRequestModel.fromJson(Map<String, dynamic> json) =>
      ScanPayRequestModel(
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
