import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/core/helper.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/status/auth_status_event.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/status/auth_status_state.dart';
import 'package:rxdart/rxdart.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  AuthStatusBloc() : super(AuthStatusLoading()) {
    on<CheckAuthStatus>(
      (event, emit) async {
        final prefs = await sharedPrefs();
        final token = prefs.getString('token');

        if (token != null) {
          emit(Authenticated());
        } else {
          emit(UnAuthenticated());
        }
      },
      // transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
