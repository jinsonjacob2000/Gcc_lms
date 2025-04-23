import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/Utilities/tokenManager.dart';
import 'package:portfolio_lms/View/student/Home_student.dart';
import 'package:portfolio_lms/View/student/courses/my_courses.dart';
import 'package:portfolio_lms/View/student/profile/profileStudent.dart';
import 'package:portfolio_lms/View/student/support_student.dart';
import 'package:portfolio_lms/Viewmodel/student_provider/studentCourse.dart';
import 'package:portfolio_lms/Viewmodel/student_provider/student_profile.dart';
import 'package:provider/provider.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    HomeStudent(),
    MyCourses(),
    SupportStudent(),
    Profilestudent(),
  ];

  void _onTabTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });

    final token = await TokenManager.getToken();

    if (token == null) {
      print("No token found");
      return; // You might also navigate to login here
    }

    if (index == 1) {
      final courseProvider = Provider.of<CourseProvider>(
        context,
        listen: false,
      );
      await courseProvider.loadCourses(token);
    }

    if (index == 3) {
      final profileProvider = Provider.of<StudentProfile>(
        context,
        listen: false,
      );
     int? userid= await TokenManager.getUserId();
      await profileProvider.getProfileProvider(token, userid!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online_outlined),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Support',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _currentIndex,

        selectedItemColor: AppColors.primaryblue,
        unselectedItemColor: AppColors.secondaryGrey,
        unselectedLabelStyle: TextStyle(color: AppColors.secondaryGrey),
        onTap: _onTabTapped,
      ),
    );
  }
}
