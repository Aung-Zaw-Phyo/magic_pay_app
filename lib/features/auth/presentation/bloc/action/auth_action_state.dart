import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/core/response_data.dart';

abstract class AuthActionState extends Equatable {
  const AuthActionState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthActionState {}

class AuthLoading extends AuthActionState {}

class AuthLoaded extends AuthActionState {
  final ResponseData result;
  const AuthLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class AuthLoadFailed extends AuthActionState {
  final String message;
  const AuthLoadFailed({required this.message});

  @override
  List<Object> get props => [message];
}
