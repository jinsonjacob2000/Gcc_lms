import 'package:flutter/material.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/Utilities/tokenManager.dart';
import 'package:portfolio_lms/View/student/Home_student.dart';
import 'package:portfolio_lms/View/student/my_courses.dart';
import 'package:portfolio_lms/View/student/profileStudent.dart';
import 'package:portfolio_lms/View/student/support_student.dart';
import 'package:portfolio_lms/Viewmodel/studentCourse.dart';
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
    Profilestudent()
  ];

   void _onTabTapped(int index) async {
  setState(() {
    _currentIndex = index;
  });

  // Assuming index 1 is the "My Courses" tab
  if (index == 1) {
    final token = await TokenManager.getToken();

    if (token != null) {
      final provider = Provider.of<CourseProvider>(context, listen: false);
      await provider.loadCourses(token);
    } else {
      // Handle case: maybe show login page
      print("No token found");
    }
  }
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
            icon: Icon(Icons.book_online_outlined),
            label: 'Courses',
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
        currentIndex: _currentIndex,

        selectedItemColor:AppColors.primaryblue,
        unselectedItemColor: AppColors.secondaryGrey,
        unselectedLabelStyle:  TextStyle(
          color: AppColors.secondaryGrey,
        ),
        onTap: _onTabTapped
      ),
     
    );
  }
}