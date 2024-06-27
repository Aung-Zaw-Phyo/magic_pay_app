import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/auth/domain/entities/user.dart';

abstract class AuthActionEvent extends Equatable {
  const AuthActionEvent();

  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthActionEvent {
  final String phone;
  final String password;
  const AuthLogin({required this.phone, required this.password});

  @override
  List<Object> get props => [phone, password];
}

class AuthLogout extends AuthActionEvent {
  const AuthLogout();

  @override
  List<Object> get props => [];
}

class AuthRegister extends AuthActionEvent {
  final UserEntity user;
  const AuthRegister({required this.user});

  @override
  List<Object> get props => [user];
}
