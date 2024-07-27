import 'package:dio/dio.dart';
import 'package:magic_pay_app/features/auth/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/auth/domain/repositories/auth_repositor.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/login.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/logout.dart';
import 'package:magic_pay_app/features/auth/domain/usecases/register.dart';
import 'package:magic_pay_app/features/home/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/home/domain/repositories/home_repository.dart';
import 'package:magic_pay_app/features/home/domain/usecases/get_profile.dart';
import 'package:magic_pay_app/features/home/domain/usecases/update_password.dart';
import 'package:magic_pay_app/features/notification/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/notification/domain/repositories/notification_repositor.dart';
import 'package:magic_pay_app/features/notification/domain/usecases/get_notification_detail.dart';
import 'package:magic_pay_app/features/notification/domain/usecases/get_notifications.dart';
import 'package:magic_pay_app/features/scan_pay/data/datasources/remote_data_source.dart';
import 'package:magic_pay_app/features/scan_pay/domain/repositories/scan_pay_repository.dart';
import 'package:magic_pay_app/features/transaction/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:magic_pay_app/features/transaction/domain/usecases/get_transaction_detail.dart';
import 'package:magic_pay_app/features/transaction/domain/usecases/get_transactions.dart';
import 'package:magic_pay_app/features/transfer/data/data_sources/remote_data_source.dart';
import 'package:magic_pay_app/features/transfer/domain/repositories/transfer_repository.dart';
import 'package:magic_pay_app/features/transfer/domain/usecases/transfer_complete.dart';
import 'package:magic_pay_app/features/transfer/domain/usecases/transfer_confirm.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    // Repository
    AuthRepository,
    HomeRepository,
    NotificationRepository,
    TransactionRepository,
    TransferRepository,
    ScanPayRepository,

    // DataSource
    AuthRemoteDataSource,
    HomeRemoteDataSource,
    NotificationRemoteDataSource,
    TransactionRemoteDataSource,
    TransferRemoteDataSource,
    ScanPayRemoteDataSource,

    // UseCases
    LoginUseCase,
    LogoutUseCase,
    RegisterUseCase,
    GetProfileUseCase,
    UpdatePasswordUseCase,
    GetNotificationsUseCase,
    GetNotificationDetailUseCase,
    GetTransactionsUseCase,
    GetTransactionDetailUseCase,
    TransferConfirmUseCase,
    TransferCompleteUseCase,

    // Others
    SharedPreferences,
  ],
  customMocks: [
    MockSpec<Dio>(as: #MockDio),
  ],
)
void main() {}
