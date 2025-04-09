import 'package:flutter/material.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/Viewmodel/Authentication/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 3 seconds before calling auto login
    Future.delayed(const Duration(seconds: 3), () {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.Adminautologin(context); // Call your login check
    });
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: AppColors.primarywhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            
            child: Center(child: Image.asset('assets/logos/gcc-logo.png')),
          ),
        ],
      ),
    );
  }
}
