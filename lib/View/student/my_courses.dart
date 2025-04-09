import 'package:flutter/material.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/Viewmodel/studentCourse.dart';
import 'package:provider/provider.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _AttendanceStudentstate();
}

class _AttendanceStudentstate extends State<MyCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Assigned couese details for the student
            assignedCourses(),
          ],
        ),
      ),
    );
  }

  Widget assignedCourses() {
    final courseProvider = Provider.of<CourseProvider>(context);

    if (courseProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (courseProvider.error != null) {
      return Center(child: Text('Error: ${courseProvider.error}'));
    } else {
      return Column(
        children: [
          Center(child: Text("Categories", style: AppTextStyles.heading)),

          Container(
            color: AppColors.primarygreen,
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 32,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipPath(
                    clipper: TopRightShorterClipper(),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}

class TopRightShorterClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double cutHeight = 40; // Drop the top-right corner by 30

    Path path = Path();
    path.moveTo(0, 0); // Top-left
    path.lineTo(size.width, cutHeight+10); // Slanted top-right
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(0, size.height); // Bottom-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}