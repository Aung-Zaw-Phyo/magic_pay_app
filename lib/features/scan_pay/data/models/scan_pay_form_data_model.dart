import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_form_data.dart';

class ScanPayFormDataModel extends ScanPayFormDataEntity {
  const ScanPayFormDataModel({
    required String fromName,
    required String fromPhone,
    required String toName,
    required String toPhone,
  }) : super(
          fromName: fromName,
          fromPhone: fromPhone,
          toName: toName,
          toPhone: toPhone,
        );

  factory ScanPayFormDataModel.fromJson(Map<String, dynamic> json) =>
      ScanPayFormDataModel(
        fromName: json['from_name'],
        fromPhone: json['from_phone'],
        toName: json['to_name'],
        toPhone: json['to_phone'],
      );

  Map<String, dynamic> toJson() => {
        'from_name': fromName,
        'from_phone': fromPhone,
        'to_name': toName,
        'to_phone': toPhone,
      };
}
