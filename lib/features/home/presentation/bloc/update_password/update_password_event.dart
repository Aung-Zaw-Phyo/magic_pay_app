import 'package:equatable/equatable.dart';

abstract class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object> get props => [];
}

class UpdatePassword extends UpdatePasswordEvent {
  final String oldPassword;
  final String newPassword;
  const UpdatePassword({required this.oldPassword, required this.newPassword});

  @override
  List<Object> get props => [oldPassword, newPassword];
}
