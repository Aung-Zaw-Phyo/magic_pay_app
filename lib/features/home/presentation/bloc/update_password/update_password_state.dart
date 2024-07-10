import 'package:equatable/equatable.dart';

abstract class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object> get props => [];
}

class UpdatePasswordInitial extends UpdatePasswordState {}

class UpdatePasswordLoading extends UpdatePasswordState {}

class UpdatePasswordLoaded extends UpdatePasswordState {}

class UpdatePasswordLoadFailed extends UpdatePasswordState {
  final String message;
  const UpdatePasswordLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
