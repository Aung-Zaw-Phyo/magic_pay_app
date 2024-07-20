import 'package:flutter/material.dart';
import 'package:magic_pay_app/features/auth/presentation/pages/login_screen.dart';
import 'package:magic_pay_app/features/auth/presentation/pages/register_screen.dart';
import 'package:magic_pay_app/features/home/presentation/pages/account_screen.dart';
import 'package:magic_pay_app/features/home/presentation/pages/tabs_screen.dart';
import 'package:magic_pay_app/features/notification/presentation/pages/notification_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const TabsScreen());

      case '/login':
        return _materialRoute(const LoginScreen());

      case '/register':
        return _materialRoute(const RegisterScreen());

      case '/account':
        return _materialRoute(const AccountScreen());

      case '/notification':
        return _materialRoute(const NotificationScreen());

      default:
        return _materialRoute(const TabsScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}







// import 'package:flutter/material.dart';
// import 'package:magic_pay_app/features/auth/presentation/pages/login_screen.dart';
// import 'package:magic_pay_app/features/auth/presentation/pages/register_screen.dart';
// import 'package:magic_pay_app/screens/account.dart';
// import 'package:magic_pay_app/screens/tabs.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AppRoutes {
//   static Route onGenerateRoutes(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return _materialRoute(const TabsScreen());
//       case '/login':
//         return _materialRoute(const LoginScreen());
//       case '/register':
//         return _materialRoute(const RegisterScreen());
//       case '/account':
//         return _materialRoute(const AccountScreen());
//       default:
//         return _materialRoute(const LoginScreen());
//     }
//   }

//   static Route<dynamic> _materialRoute(Widget view) {
//     return MaterialPageRoute(builder: (_) => view);
//   }

//   static Route _guardedRoute(Widget view) {
//     return MaterialPageRoute(
//       builder: (context) => FutureBuilder<bool>(
//         future: hasToken(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           } else if (snapshot.hasData && snapshot.data == true) {
//             return view;
//           } else {
//             return const LoginScreen();
//           }
//         },
//       ),
//     );
//   }

//   static Route _nonGuardedRoute(Widget view) {
//     return MaterialPageRoute(
//       builder: (context) => FutureBuilder<bool>(
//         future: hasToken(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           } else if (snapshot.hasData && snapshot.data == true) {
//             return const TabsScreen();
//           } else {
//             return view;
//           }
//         },
//       ),
//     );
//   }

//   static Future<bool> hasToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     return token != null && token.isNotEmpty;
//   }
// }
