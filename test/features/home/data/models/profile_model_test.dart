import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/home/data/models/profile_model.dart';
import 'package:magic_pay_app/features/home/domain/entities/Profile.dart';

void main() {
  const testProfileModel = ProfileModel(
    name: "Tester",
    email: "tester@gmail.com",
    phone: "123456",
    accountNumber: "876872478236478234",
    balance: "300000",
    profile: "profile image",
    receiveQrValue: "123456",
    unreadNotiCount: 0,
  );

  const jsonMap = {
    "name": "Tester",
    "email": "tester@gmail.com",
    "phone": "123456",
    "account_number": "876872478236478234",
    "balance": "300000",
    "profile": "profile image",
    "receive_qr_value": "123456",
    "unread_noti_count": 0,
  };

  group('profile model', () {
    test('should be a sub class of profile entity', () {
      expect(testProfileModel, isA<ProfileEntity>());
    });

    test("should return a valid model from json", () {
      // act
      final result = ProfileModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testProfileModel));
    });

    test("should return a json map containing proper data", () {
      // act
      final result = testProfileModel.toJson();

      // assert
      expect(result, equals(jsonMap));
    });
  });
}
