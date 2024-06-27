import 'package:flutter_test/flutter_test.dart';
import 'package:magic_pay_app/features/auth/data/models/user.dart';
import 'package:magic_pay_app/features/auth/domain/entities/user.dart';

void main() {
  const testUserModel = UserModel(
    name: 'Tester',
    email: 'tester@gmail.com',
    phone: '290348043',
    password: 'password',
  );

  group('user model', () {
    test('should be a sub class of user entity', () {
      expect(testUserModel, isA<UserEntity>());
    });

    test('should return a json map containing proper data.', () {
      // act
      final result = testUserModel.toJson();

      // assert
      const expectedJsonMap = {
        "name": "Tester",
        "email": "tester@gmail.com",
        "phone": "290348043",
        "password": "password",
      };

      expect(result, equals(expectedJsonMap));
    });
  });
}
