import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/transfer/data/models/transfer_request_model.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';

void main() {
  const testTransferRequestModel = TransferRequestModel(
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

  group('transfer request model', () {
    test('should be a sub class of transfer request entity', () {
      expect(testTransferRequestModel, isA<TransferRequestEntity>());
    });

    test("should return a json map containing proper data", () {
      // act
      final result = testTransferRequestModel.toJson();

      // assert
      expect(result, equals(jsonMap));
    });
  });
}
