import 'package:flutter/material.dart';
import 'package:zizzlepop/screens/splash_screen.dart';
import 'package:zizzlepop/utils/constants.dart';

void main() => runApp(const ZizzlePopApp());

class ZizzlePopApp extends StatelessWidget {
  const ZizzlePopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZizzlePop',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: kBackgroundColor,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}