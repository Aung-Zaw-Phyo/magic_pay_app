import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/home/domain/usecases/update_password.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/update_password/update_password_event.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/update_password/update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final UpdatePasswordUseCase updatePasswordUseCase;
  UpdatePasswordBloc(this.updatePasswordUseCase)
      : super(UpdatePasswordInitial()) {
    on<UpdatePassword>((event, emit) async {
      final result = await updatePasswordUseCase.execute(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      );
      result.fold((failure) {
        emit(UpdatePasswordLoadFailed(failure.message));
      }, (data) {
        emit(UpdatePasswordLoaded());
      });
    });
  }
}
