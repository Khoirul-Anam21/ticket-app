import 'dart:io';

import 'package:flutter/material.dart';

import 'package:ticket_app/pages/login_page.dart';

void main() {
  HttpOverrides.global = OverrideHTTP();
  runApp(MyApp());
}

class OverrideHTTP extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Evnt.in - Aplikasi Event',
        theme: ThemeData(
            primaryColor: Color(0xff007E80),
            fontFamily: 'Segoe UI',
            textTheme: TextTheme(
                headline1: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
                headline6: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                bodyText1:
                    TextStyle(fontSize: 18, color: const Color(0xff007E80)),
                bodyText2: TextStyle(fontSize: 10),
                caption: TextStyle(fontSize: 12, color: Colors.black))),
        home: LoginPage(),
        debugShowCheckedModeBanner: false);
  }
}
