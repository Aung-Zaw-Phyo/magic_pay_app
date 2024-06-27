import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void success(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ),
  );
}

void error(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}

Future<SharedPreferences> sharedPrefs() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

Future<bool> hasToken() async {
  final prefs = await sharedPrefs();
  final token = prefs.getString('token');
  return token != null && token.isNotEmpty;
}
