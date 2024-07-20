import 'package:get_it/get_it.dart';
import 'package:magic_pay_app/core/dio_client.dart';
import 'package:magic_pay_app/features/auth/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:magic_pay_app/features/auth/domain/repositories/auth_repositor.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/login.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/logout.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/register.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/action/auth_action_bloc.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/status/auth_status_bloc.dart';
import 'package:magic_pay_app/features/home/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:magic_pay_app/features/home/domain/repositories/home_repository.dart';
import 'package:magic_pay_app/features/home/domain/usecases/get_profile.dart';
import 'package:magic_pay_app/features/home/domain/usecases/update_password.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/update_password/update_password_bloc.dart';
import 'package:magic_pay_app/features/notification/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:magic_pay_app/features/notification/domain/repositories/notification_repositor.dart';
import 'package:magic_pay_app/features/notification/domain/usecases/get_notification_detail.dart';
import 'package:magic_pay_app/features/notification/domain/usecases/get_notifications.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_bloc.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_bloc.dart';

final locator = GetIt.instance;

void setupLocator() async {
  // bloc
  locator.registerFactory<AuthActionBloc>(
    () => AuthActionBloc(
      loginUseCase: locator(),
      logoutUseCase: locator(),
      registerUseCase: locator(),
    ),
  );
  locator.registerFactory<AuthStatusBloc>(() => AuthStatusBloc());
  locator.registerFactory<ProfileBloc>(() => ProfileBloc(locator()));
  locator
      .registerFactory<UpdatePasswordBloc>(() => UpdatePasswordBloc(locator()));

  locator
      .registerFactory<NotificationsBloc>(() => NotificationsBloc(locator()));
  locator.registerFactory<NotificationDetailBloc>(
      () => NotificationDetailBloc(locator()));

  // usecase
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));
  locator.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(locator()));
  locator
      .registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(locator()));
  locator.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(locator()));
  locator.registerLazySingleton<UpdatePasswordUseCase>(
      () => UpdatePasswordUseCase(locator()));

  locator.registerLazySingleton<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(locator()));
  locator.registerLazySingleton<GetNotificationDetailUseCase>(
      () => GetNotificationDetailUseCase(locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator()));
  locator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(locator()));
  locator.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(locator()));

  // datasource
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(locator()));

  // external

  locator.registerLazySingleton(() => dio_client);
}
