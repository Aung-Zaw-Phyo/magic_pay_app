import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_data_model.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_data.dart';

void main() {
  const testScanPayDataModel = ScanPayDataModel(
    fromName: 'Aung Zaw Phyo',
    fromPhone: '09968548024',
    toName: 'Mary',
    toPhone: '09968548025',
    amount: 3000,
    description: 'description',
    hashValue: 'hashValue',
  );
  const jsonMap = {
    'from_name': 'Aung Zaw Phyo',
    'from_phone': '09968548024',
    'to_name': 'Mary',
    'to_phone': '09968548025',
    'amount': 3000,
    'description': 'description',
    'hash_value': 'hashValue',
  };
  group('scanpay data model', () {
    test('should be a sub class of ScanPay data entity', () {
      expect(testScanPayDataModel, isA<ScanPayDataEntity>());
    });

    test("should return a valid model from json", () {
      final result = ScanPayDataModel.fromJson(jsonMap);

      expect(result, equals(testScanPayDataModel));
    });

    test("should return a json map containing proper data", () {
      final result = testScanPayDataModel.toJson();

      expect(result, equals(jsonMap));
    });
  });
}
