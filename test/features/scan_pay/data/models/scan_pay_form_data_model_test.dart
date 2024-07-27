import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_form_data_model.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_form_data.dart';

void main() {
  const testScanPayFormDataModel = ScanPayFormDataModel(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '09968548024',
    toName: 'Mary',
    toPhone: '09968548025',
  );
  const jsonMap = {
    'from_name': 'Aung Zaw Phyo',
    'from_phone': '09968548024',
    'to_name': 'Mary',
    'to_phone': '09968548025',
  };
  group('scanpay form data model', () {
    test('should be a sub class of ScanPay form data entity', () {
      expect(testScanPayFormDataModel, isA<ScanPayFormDataEntity>());
    });

    test("should return a valid model from json", () {
      final result = ScanPayFormDataModel.fromJson(jsonMap);

      expect(result, equals(testScanPayFormDataModel));
    });

    test("should return a json map containing proper data", () {
      final result = testScanPayFormDataModel.toJson();

      expect(result, equals(jsonMap));
    });
  });
}
