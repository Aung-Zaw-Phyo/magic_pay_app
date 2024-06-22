import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:magic_pay_app/screens/Login.dart';
import 'package:magic_pay_app/screens/Register.dart';
import 'package:magic_pay_app/screens/tabs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const TabsScreen(),
    );
  }
}
