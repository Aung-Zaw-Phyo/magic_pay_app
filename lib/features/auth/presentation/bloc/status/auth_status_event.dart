import 'package:equatable/equatable.dart';

abstract class AuthStatusEvent extends Equatable {
  const AuthStatusEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthStatus extends AuthStatusEvent {
  const CheckAuthStatus();

  @override
  List<Object> get props => [];
}
