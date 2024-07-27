import 'package:flutter/material.dart';
import 'package:magic_pay_app/features/auth/presentation/pages/login_screen.dart';
import 'package:magic_pay_app/features/auth/presentation/pages/register_screen.dart';
import 'package:magic_pay_app/features/home/presentation/pages/account_screen.dart';
import 'package:magic_pay_app/features/home/presentation/pages/tabs_screen.dart';
import 'package:magic_pay_app/features/notification/presentation/pages/notification_detail_screen.dart';
import 'package:magic_pay_app/features/notification/presentation/pages/notification_screen.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/pages/pay_confirm_screen.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/pages/pay_form_screen.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/pages/scan_qr_screen.dart';
import 'package:magic_pay_app/features/transaction/presentation/pages/transaction_detail_screen.dart';
import 'package:magic_pay_app/features/transaction/presentation/pages/transaction_screen.dart';
import 'package:magic_pay_app/features/transfer/presentation/pages/transfer_confirm_screen.dart';
import 'package:magic_pay_app/features/transfer/presentation/pages/transfer_screen.dart';
import 'package:magic_pay_app/screens/receive_qr.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const TabsScreen());

      case '/login':
        return _materialRoute(const LoginScreen());

      case '/register':
        return _materialRoute(const RegisterScreen());

      case '/profile':
        return _materialRoute(const AccountScreen());

      case '/receive_qr':
        return _materialRoute(const ReceiveQrScreen());

      case '/notification':
        return _materialRoute(const NotificationScreen());

      case '/notification_detail':
        final notificationId = settings.arguments as String;
        return _materialRoute(
          NotificationDetailScreen(notificationId: notificationId),
        );

      case '/transaction':
        return _materialRoute(const TransactionScreen());

      case '/transaction_detail':
        final transactionId = settings.arguments as String;
        return _materialRoute(
          TransactionDetailScreen(transactionId: transactionId),
        );

      case '/transfer':
        return _materialRoute(const TransferScreen());

      case '/transfer_confirm':
        return _materialRoute(const TransferConfirmScreen());

      case '/scan_qr':
        return _materialRoute(const ScanQrScreen());

      case '/pay_form':
        return _materialRoute(const PayFormScreen());

      case '/pay_confirm':
        return _materialRoute(const PayConfirmScreen());

      default:
        return _materialRoute(const TabsScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
