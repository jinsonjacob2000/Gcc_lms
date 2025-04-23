// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio_lms/Models/coursesModel/Student_model.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';

class HomeStudent extends StatefulWidget {
  const HomeStudent({super.key});

  @override
  State<HomeStudent> createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudent> {
  List<CourseCategory> categories = [
    CourseCategory(
      heading: 'Programming',
      subheading: 'Learn to code',
      numberOfCourses: '12courses',
      description: 'Covers Dart, Flutter, Python, Java, and more.',
    ),
    CourseCategory(
      heading: 'Design',
      subheading: 'UI/UX Basics',
      numberOfCourses: '8courses',
      description: 'Explore Figma, Adobe XD, color theory, and layout.',
    ),
    CourseCategory(
      heading: 'Marketing',
      subheading: 'Digital Growth',
      numberOfCourses: '5corses',
      description: 'SEO, social media, branding, and content strategy.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [Expanded(child: advertisement()), 
          //  assignedCourse()
            ],
          ),
        ),
      ),
    );
  }

  Widget advertisement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("New Courses", style: AppTextStyles.heading),
        ),
        AppSpacing.hsmall,
        Expanded(
          child: ListView.builder(
            itemCount: categories.length > 2 ? 2 : categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                width: 400,
                height: 200,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category.heading, style: AppTextStyles.heading),
                    Text(category.subheading, style: AppTextStyles.heading),
                    AppSpacing.hsmall,
                    Text(
                      category.numberOfCourses,
                      style: AppTextStyles.subHeading,
                    ),

                    Text(category.description, style: AppTextStyles.body),
                    AppSpacing.hmedium,
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("view course details"),
                        ),
                      ],
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

//   Widget assignedCourse() {
//     return Column(children: [
//      Text("Assigned couesrs",style: AppTextStyles.heading,),
//      ListView.builder(itemBuilder: );
//       ],
//     );
//   }
}
