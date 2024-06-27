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
import 'package:magic_pay_app/injection_container.dart';
import 'package:magic_pay_app/screens/tabs.dart';

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
