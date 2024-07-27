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
import 'package:magic_pay_app/features/scan_pay/data/datasources/remote_data_source.dart';
import 'package:magic_pay_app/features/scan_pay/data/repositories/scan_pay_repository_impl.dart';
import 'package:magic_pay_app/features/scan_pay/domain/repositories/scan_pay_repository.dart';
import 'package:magic_pay_app/features/scan_pay/domain/usecases/pay_complete.dart';
import 'package:magic_pay_app/features/scan_pay/domain/usecases/pay_confirm.dart';
import 'package:magic_pay_app/features/scan_pay/domain/usecases/scan_qr_code.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_complete/pay_complete_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_bloc.dart';
import 'package:magic_pay_app/features/transaction/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:magic_pay_app/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:magic_pay_app/features/transaction/domain/usecases/get_transaction_detail.dart';
import 'package:magic_pay_app/features/transaction/domain/usecases/get_transactions.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_bloc.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:magic_pay_app/features/transfer/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/transfer/data/repositories/transfer_repository_impl.dart';
import 'package:magic_pay_app/features/transfer/domain/repositories/transfer_repository.dart';
import 'package:magic_pay_app/features/transfer/domain/usecases/transfer_complete.dart';
import 'package:magic_pay_app/features/transfer/domain/usecases/transfer_confirm.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_complete/transfer_complete_bloc.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_bloc.dart';

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

  locator.registerFactory<TransactionsBloc>(() => TransactionsBloc(locator()));
  locator.registerFactory<TransactionDetailBloc>(
      () => TransactionDetailBloc(locator()));

  locator.registerFactory<TransferConfirmBloc>(
      () => TransferConfirmBloc(locator()));
  locator.registerFactory<TransferCompleteBloc>(
      () => TransferCompleteBloc(locator()));

  locator.registerFactory<ScanQrCodeBloc>(() => ScanQrCodeBloc(locator()));
  locator.registerFactory<PayConfirmBloc>(() => PayConfirmBloc(locator()));
  locator.registerFactory<PayCompleteBloc>(() => PayCompleteBloc(locator()));

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

  locator.registerLazySingleton<GetTransactionsUseCase>(
      () => GetTransactionsUseCase(locator()));
  locator.registerLazySingleton<GetTransactionDetailUseCase>(
      () => GetTransactionDetailUseCase(locator()));

  locator.registerLazySingleton<TransferConfirmUseCase>(
      () => TransferConfirmUseCase(locator()));
  locator.registerLazySingleton<TransferCompleteUseCase>(
      () => TransferCompleteUseCase(locator()));

  locator.registerLazySingleton<ScanQrCodeUseCase>(
      () => ScanQrCodeUseCase(locator()));
  locator.registerLazySingleton<PayConfirmUseCase>(
      () => PayConfirmUseCase(locator()));
  locator.registerLazySingleton<PayCompleteUseCase>(
      () => PayCompleteUseCase(locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator()));
  locator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(locator()));
  locator.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(locator()));
  locator.registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(locator()));
  locator.registerLazySingleton<TransferRepository>(
      () => TransferRepositoryImpl(locator()));
  locator.registerLazySingleton<ScanPayRepository>(
      () => ScanPayRepositoryImpl(locator()));

  // datasource
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<TransferRemoteDataSource>(
      () => TransferRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<ScanPayRemoteDataSource>(
      () => ScanPayRemoteDataSourceImpl(locator()));

  // external

  locator.registerLazySingleton(() => dio_client);
}
