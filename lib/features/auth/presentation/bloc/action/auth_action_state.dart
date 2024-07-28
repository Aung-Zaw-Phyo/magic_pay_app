import 'package:equatable/equatable.dart';

abstract class AuthActionState extends Equatable {
  const AuthActionState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthActionState {}

class AuthLoading extends AuthActionState {}

class AuthLoaded extends AuthActionState {
  const AuthLoaded();
}

class AuthLoadFailed extends AuthActionState {
  final String message;
  const AuthLoadFailed({required this.message});

  @override
  List<Object> get props => [message];
}
