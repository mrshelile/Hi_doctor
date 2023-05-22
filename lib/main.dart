import 'package:flutter/material.dart';
import 'package:hi_doctor/screens/Login/LoginForm.dart';
import 'package:hi_doctor/screens/Onboarding/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnBoarding(),
    );
  }
}
