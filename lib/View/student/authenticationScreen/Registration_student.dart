import 'package:flutter/material.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/View/student/authenticationScreen/Login_student.dart';
import 'package:portfolio_lms/Viewmodel/Authentication/auth_provider.dart';
import 'package:provider/provider.dart';

class RegistrationStudent extends StatefulWidget {
  const RegistrationStudent({super.key});

  @override
  State<RegistrationStudent> createState() => _RegistrationStudentState();
}

class _RegistrationStudentState extends State<RegistrationStudent> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController rolecontroller = TextEditingController();
  TextEditingController tphone = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.primarywhite,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                AppSpacing.hmedium,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Welcome Back!", style: AppTextStyles.heading),
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
                  controller: namecontroller,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: AppTextStyles.body,
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
                  //     r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
                  //   ).hasMatch(value)) {
                  //     return 'Enter a valid email';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: AppTextStyles.body,
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
                  //     r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
                  //   ).hasMatch(value)) {
                  //     return 'Enter a valid email';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: AppTextStyles.body,
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
                SizedBox(height: 20),
                TextFormField(
                  controller: rolecontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Role",
                    labelStyle: AppTextStyles.body,
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
                SizedBox(height: 20),

                TextFormField(
                  controller: tphone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: AppTextStyles.body,
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
                  //     r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
                  //   ).hasMatch(value)) {
                  //     return 'Enter a valid email';
                  //   }
                  //   return null;
                  // },
                ),

                SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: ElevatedButton(
                    onPressed: () {
                      if (namecontroller.text.isEmpty ||
                          emailcontroller.text.isEmpty ||
                          passwordcontroller.text.isEmpty ||
                          rolecontroller.text.isEmpty ||
                          tphone.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill all the fields")),
                        );
                      } else {
                        authViewModel.register(
                          namecontroller.text,
                          emailcontroller.text,
                          passwordcontroller.text,
                          rolecontroller.text,
                          tphone.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryblue,
                      foregroundColor: Colors.black,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child:authViewModel.isLoading==true?CircularProgressIndicator() : Text("Register", style: AppTextStyles.subwhite),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginStudent()),
                      );
                    }
                  },
                  child: Text(
                    "Already a User? Login",
                    style: TextStyle(fontFamily: 'Galano', color: Colors.black),
                  ),
                ),Text(
                  authViewModel.message ?? "",
                  style: TextStyle(
                    color: authViewModel.message == "User registered successfully"
                        ? Colors.green
                        : Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
