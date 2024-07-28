import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/login.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/logout.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/register.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_event.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_state.dart';
import 'package:rxdart/rxdart.dart';

class AuthActionBloc extends Bloc<AuthActionEvent, AuthActionState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;
  AuthActionBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
  }) : super(AuthInitial()) {
    on<AuthLogin>(
      onLogin,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<AuthLogout>(
      onLogout,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<AuthRegister>(
      onRegister,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void onLogin(AuthLogin event, Emitter<AuthActionState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase.execute(
        phone: event.phone, password: event.password);
    final prefs = await sharedPrefs();
    result.fold(
      (failure) {
        emit(AuthLoadFailed(message: failure.message));
      },
      (data) {
        prefs.setString('token', data);
        emit(const AuthLoaded());
      },
    );
  }

  void onLogout(AuthLogout event, Emitter<AuthActionState> emit) async {
    emit(AuthLoading());
    final result = await logoutUseCase.execute();
    final prefs = await sharedPrefs();

    result.fold(
      (failure) {
        emit(AuthLoadFailed(message: failure.message));
      },
      (data) {
        prefs.remove('token');
        emit(const AuthLoaded());
      },
    );
  }

  void onRegister(AuthRegister event, Emitter<AuthActionState> emit) async {
    emit(AuthLoading());
    final result = await registerUseCase.execute(event.user);
    final prefs = await sharedPrefs();

    result.fold(
      (failure) {
        emit(AuthLoadFailed(message: failure.message));
      },
      (data) {
        prefs.setString('token', data);
        emit(const AuthLoaded());
      },
    );
  }

  // @override
  // Stream<AuthActionState> mapEventToState(AuthActionEvent event) async* {
  //   if (event is AuthLoaded) {
  //     print('================================');
  //   }
  // }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
