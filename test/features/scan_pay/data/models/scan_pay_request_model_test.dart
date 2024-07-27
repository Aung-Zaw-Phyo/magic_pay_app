import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/scan_pay/data/models/scan_pay_request_model.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';

void main() {
  const testScanPayRequestModel = ScanPayRequestModel(
    toPhone: '09968548025',
    amount: 3000,
    hashValue: 'hashValue',
    description: 'description',
    password: 'password',
  );
  const jsonMap = {
    'to_phone': '09968548025',
    'amount': 3000,
    'hash_value': 'hashValue',
    'description': 'description',
    'password': 'password',
  };
  group('scanpay request model', () {
    test('should be a sub class of ScanPay request entity', () {
      expect(testScanPayRequestModel, isA<ScanPayRequestEntity>());
    });

    test("should return a valid model from json", () {
      final result = ScanPayRequestModel.fromJson(jsonMap);

      expect(result, equals(testScanPayRequestModel));
    });

    test("should return a json map containing proper data", () {
      final result = testScanPayRequestModel.toJson();

      expect(result, equals(jsonMap));
    });
  });
}
