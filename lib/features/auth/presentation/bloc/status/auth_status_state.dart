import 'package:equatable/equatable.dart';

abstract class AuthStatusState extends Equatable {
  const AuthStatusState();

  @override
  List<Object> get props => [];
}

class AuthStatusLoading extends AuthStatusState {}

class Authenticated extends AuthStatusState {}

class UnAuthenticated extends AuthStatusState {}
