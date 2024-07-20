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
import 'package:magic_pay_app/features/notification/domain/usecases/get_notifications.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    // Repository
    AuthRepository,
    HomeRepository,
    NotificationRepository,

    // DataSource
    AuthRemoteDataSource,
    HomeRemoteDataSource,
    NotificationRemoteDataSource,

    // UseCases
    LoginUseCase,
    LogoutUseCase,
    RegisterUseCase,
    GetProfileUseCase,
    UpdatePasswordUseCase,
    GetNotificationsUseCase,

    // Others
    SharedPreferences,
  ],
  customMocks: [
    MockSpec<Dio>(as: #MockDio),
  ],
)
void main() {}
