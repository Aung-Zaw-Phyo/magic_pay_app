import 'package:magic_pay_app/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) : super(
          name: name,
          email: email,
          phone: phone,
          password: password,
        );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      };

  UserEntity toEntity() => UserEntity(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
}
