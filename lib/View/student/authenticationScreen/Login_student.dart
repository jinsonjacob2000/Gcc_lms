import 'package:flutter/material.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/View/student/authenticationScreen/Registration_student.dart';
import 'package:portfolio_lms/View/student/bottomNav.dart';
import 'package:portfolio_lms/Viewmodel/Authentication/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginStudent extends StatefulWidget {
  const LoginStudent({super.key});

  @override
  State<LoginStudent> createState() => _LoginStudentState();
}

class _LoginStudentState extends State<LoginStudent> {

  Future<void> _handleLogin() async {
  if (_formKey.currentState!.validate()) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    bool success = await authProvider.loginStudent(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.message ?? "Login successful")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Bottomnav()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.message ?? "Login failed")),
      );
    }
  }
}

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(225, 249, 252, 251),
                  const Color.fromARGB(255, 238, 237, 237),
                ],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: Image.asset('assets/logos/gcc-logo.png'),
                          ),
                        ],
                      ),
                      //  SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Welcome Back!",
                          style: AppTextStyles.heading,
                        ),
                      ),
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter your details to login",
                          style: AppTextStyles.subHeading,
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        cursorColor: Colors.cyan,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter your email';
                        //   } else if (!RegExp(
                        //           r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')
                        //       .hasMatch(value)) {
                        //     return 'Enter a valid email';
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        cursorColor: Colors.cyan,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter your password';
                        //   } else if (value.length < 6) {
                        //     return 'Password must be at least 6 characters';
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryblue,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text("Login", style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationStudent(),
                            ),
                          );
                        },
                        child: Text(
                          "Dont have account? Register",
                          style: AppTextStyles.body,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    
  }
}
