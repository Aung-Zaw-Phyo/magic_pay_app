import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/home/domain/entities/Profile.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profileEntity;
  const ProfileLoaded(this.profileEntity);

  @override
  List<Object> get props => [profileEntity];
}

class ProfileLoadFailed extends ProfileState {
  final String message;
  const ProfileLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
