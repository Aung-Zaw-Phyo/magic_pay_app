import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/transfer/data/models/transfer_data_model.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_data.dart';

void main() {
  const testTransferDataModel = TransferDataModel(
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

  group('transfer data model', () {
    test('should be a sub class of transfer data entity', () {
      expect(testTransferDataModel, isA<TransferDataEntity>());
    });

    test("should return a valid model from json", () {
      // act
      final result = TransferDataModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testTransferDataModel));
    });

    test("should return a json map containing proper data", () {
      // act
      final result = testTransferDataModel.toJson();

      // assert
      expect(result, equals(jsonMap));
    });
  });
}
