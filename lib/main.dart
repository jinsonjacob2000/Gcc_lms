import 'package:flutter/material.dart';
import 'package:portfolio_lms/View/commons/splash_screen.dart';
import 'package:portfolio_lms/View/student/Home_student.dart';
import 'package:portfolio_lms/View/student/bottomNav.dart';
import 'package:portfolio_lms/View/student/courses/myCoursePage.dart';
import 'package:portfolio_lms/Viewmodel/Authentication/auth_provider.dart';
import 'package:portfolio_lms/Viewmodel/student_provider/studentCourse.dart';
import 'package:portfolio_lms/Viewmodel/student_provider/student_profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => StudentProfile()),

        // Provide AuthViewModel
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
    return MaterialApp(home: SplashScreen());
  }
}
