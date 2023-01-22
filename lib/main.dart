import 'package:flutter/material.dart';
import 'package:rentvehicle_application/screen/StepperForm.dart';
import 'package:rentvehicle_application/screen/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}
