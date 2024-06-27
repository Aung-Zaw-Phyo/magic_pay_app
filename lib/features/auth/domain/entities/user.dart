import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/auth/data/models/user.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String password;
  const UserEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  UserModel toModel() => UserModel(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

  @override
  List<Object> get props => [
        name,
        email,
        phone,
        password,
      ];
}
