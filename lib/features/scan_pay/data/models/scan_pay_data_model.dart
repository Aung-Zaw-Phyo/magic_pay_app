import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_data.dart';

class ScanPayDataModel extends ScanPayDataEntity {
  const ScanPayDataModel({
    required String fromName,
    required String fromPhone,
    required String toName,
    required String toPhone,
    required int amount,
    String? description,
    required String hashValue,
  }) : super(
          fromName: fromName,
          fromPhone: fromPhone,
          toName: toName,
          toPhone: toPhone,
          amount: amount,
          description: description,
          hashValue: hashValue,
        );

  factory ScanPayDataModel.fromJson(Map<String, dynamic> json) =>
      ScanPayDataModel(
        fromName: json['from_name'],
        fromPhone: json['from_phone'],
        toName: json['to_name'],
        toPhone: json['to_phone'],
        amount: json['amount'],
        description: json['description'],
        hashValue: json['hash_value'],
      );

  Map<String, dynamic> toJson() => {
        'from_name': fromName,
        'from_phone': fromPhone,
        'to_name': toName,
        'to_phone': toPhone,
        'amount': amount,
        'description': description,
        'hash_value': hashValue,
      };
}
