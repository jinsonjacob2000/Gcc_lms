import 'package:flutter/material.dart';
import 'package:portfolio_lms/View/commons/splash_screen.dart';
import 'package:portfolio_lms/Viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), // Provide AuthViewModel
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: const SplashScreen(),
    );
  }
}

