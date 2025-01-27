import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:magic_pay_app/config/routes/routes.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/status/auth_status_bloc.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/status/auth_status_event.dart';
import 'package:magic_pay_app/features/auth/presentation/bloc/status/auth_status_state.dart';
import 'package:magic_pay_app/features/auth/presentation/pages/login_screen.dart';
import 'package:magic_pay_app/features/auth/presentation/pages/splash_screen.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/profile/profile_bloc.dart';
import 'package:magic_pay_app/features/home/presentation/bloc/update_password/update_password_bloc.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notification_detail/notification_detail_bloc.dart';
import 'package:magic_pay_app/features/notification/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_complete/pay_complete_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/pay_confirm/pay_confirm_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_bloc.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transaction_detail/transaction_detail_bloc.dart';
import 'package:magic_pay_app/features/transaction/presentation/bloc/transactions/transactions_bloc.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_complete/transfer_complete_bloc.dart';
import 'package:magic_pay_app/features/transfer/presentation/bloc/transfer_confirm/transfer_confirm_bloc.dart';
import 'package:magic_pay_app/injection_container.dart';
import 'package:magic_pay_app/features/home/presentation/pages/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthStatusBloc>(create: (_) => locator<AuthStatusBloc>()),
        BlocProvider<ProfileBloc>(create: (_) => locator<ProfileBloc>()),
        BlocProvider<UpdatePasswordBloc>(
            create: (_) => locator<UpdatePasswordBloc>()),
        BlocProvider<NotificationsBloc>(
            create: (_) => locator<NotificationsBloc>()),
        BlocProvider<NotificationDetailBloc>(
            create: (_) => locator<NotificationDetailBloc>()),
        BlocProvider<TransactionsBloc>(
            create: (_) => locator<TransactionsBloc>()),
        BlocProvider<TransactionDetailBloc>(
            create: (_) => locator<TransactionDetailBloc>()),
        BlocProvider<TransferConfirmBloc>(
            create: (_) => locator<TransferConfirmBloc>()),
        BlocProvider<TransferCompleteBloc>(
            create: (_) => locator<TransferCompleteBloc>()),
        BlocProvider<ScanQrCodeBloc>(create: (_) => locator<ScanQrCodeBloc>()),
        BlocProvider<PayConfirmBloc>(create: (_) => locator<PayConfirmBloc>()),
        BlocProvider<PayCompleteBloc>(
            create: (_) => locator<PayCompleteBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Magic Pay',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: HexColor('#5842e3'),
            background: HexColor('#EDEDF5'),
          ),
          textTheme: GoogleFonts.latoTextTheme().copyWith(
            titleLarge: GoogleFonts.lato(),
            titleMedium: GoogleFonts.lato(),
            titleSmall: GoogleFonts.lato(),
          ),
        ),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const Check(),
      ),
    );
  }
}

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() {
    return _CheckState();
  }
}

class _CheckState extends State<Check> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthStatusBloc>(context).add(const CheckAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthStatusBloc, AuthStatusState>(
        builder: (context, state) {
      if (state is AuthStatusLoading) {
        return const SplashScreen();
      }
      if (state is UnAuthenticated) {
        return const LoginScreen();
      }

      return const TabsScreen();
    });
  }
}
