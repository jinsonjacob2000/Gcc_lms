import 'package:flutter/material.dart';
import 'package:portfolio_lms/Models/coursesModel/Student_model.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/View/student/courses/myCoursePage.dart';
import 'package:portfolio_lms/Viewmodel/student_provider/studentCourse.dart';
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

          AppSpacing.hlarge,
          Container(
            color: AppColors.primarywhite,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: courseProvider.courses.length,
              itemBuilder: (context, index) {
                final course = courseProvider.courses[index];

                return Container(
                  color: AppColors.secondaryGrey,
                  margin: EdgeInsets.all(8),
                  height: 150,
                  width: 150,
                  child: Column(
                    children: [
                      Text(course.courseName, style: AppTextStyles.subHeading),
                      AppSpacing.hmedium,
                      Text(
                        course.courseDescription,
                        style: AppTextStyles.subHeading,
                      ),
                      AppSpacing.hsmall,
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) {
                                return Mycoursepage(courseId:course.courseId,batchId: course.batchId,);
                              },
                            ),
                          );
                        },
                        child: Text("View"),
                      ),
                    ],
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
