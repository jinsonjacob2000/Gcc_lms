import 'package:flutter/material.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/View/student/Home_student.dart';
import 'package:portfolio_lms/View/student/attendance_student.dart';
import 'package:portfolio_lms/View/student/profileStudent.dart';
import 'package:portfolio_lms/View/student/support_student.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {

    int _currentIndex = 0;


    final List<Widget> pages = [
    HomeStudent(),
    AttendanceStudent(),
    SupportStudent(),
    Profilestudent()
  ];

    void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories_outlined),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Support',
          ),
          
          BottomNavigationBarItem(
            
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor:AppColors.primaryblue,
        unselectedItemColor: AppColors.secondaryGrey,
        unselectedLabelStyle:  TextStyle(
          color: AppColors.secondaryGrey,
        ),
        onTap: _onItemTapped
      ),
     
    );
  }
}