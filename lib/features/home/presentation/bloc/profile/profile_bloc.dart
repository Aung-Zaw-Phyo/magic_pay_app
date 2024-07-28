import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/home/domain/usecases/get_profile.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_event.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  ProfileBloc(this.getProfileUseCase) : super(ProfileLoading()) {
    on<GetProfile>((event, emit) async {
      final result = await getProfileUseCase.execute();
      result.fold((failure) {
        emit(ProfileLoadFailed(failure.message));
      }, (data) {
        emit(ProfileLoaded(data));
      });
    });
  }
}
