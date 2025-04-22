// import 'package:flutter/material.dart';
// import 'package:portfolio_lms/Utilities/Constants.dart';
// import 'package:portfolio_lms/Viewmodel/studentCourse.dart';
// import 'package:provider/provider.dart';

// class MyCourses extends StatefulWidget {
//   const MyCourses({super.key});

//   @override
//   State<MyCourses> createState() => _AttendanceStudentstate();
// }

// class _AttendanceStudentstate extends State<MyCourses> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Assigned couese details for the student
//             assignedCourses(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget assignedCourses() {
//     final courseProvider = Provider.of<CourseProvider>(context);

//     if (courseProvider.isLoading) {
//       return Center(child: CircularProgressIndicator());
//     } else if (courseProvider.error != null) {
//       return Center(child: Text('Error: ${courseProvider.error}'));
//     } else {
//       return Column(
//         children: [
//           Center(child: Text("Categories", style: AppTextStyles.heading)),

//           Container(
//             color: AppColors.primarygreen,
//             height: 200,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 32,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ClipPath(
//                     clipper: DiagonalClipper(),
//                     child: Container(
//                       width: 150,
//                       height: 150,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     }
//   }
// }

// class DiagonalClipper extends CustomClipper<Path> {
//   final double radius;

//   DiagonalClipper({this.radius = 20});

//   @override
//   Path getClip(Size size) {
//     final path = Path();

//     // Start at top-left curve
//     path.moveTo(radius, 0);
//     path.quadraticBezierTo(0, 0, 0, radius); // Top-left

//     // Left side down
//     path.lineTo(0, size.height - radius);
//     path.quadraticBezierTo(0, size.height, radius, size.height); // Bottom-left

//     // Bottom side to right
//     path.lineTo(size.width - radius, size.height);
//     path.quadraticBezierTo(size.width, size.height, size.width, size.height - radius); // Bottom-right

//     // Right side upward until diagonal start
//     path.lineTo(size.width, radius + 60);
//     path.quadraticBezierTo(size.width, radius + 40, size.width - radius, 60); // Curve before diagonal

//     // Diagonal cut from top-right towards mid-top
//     path.lineTo(size.width - 140 + radius, 0);

//     // Curve joining back to top edge (smooth curve to match)
//     path.quadraticBezierTo(size.width - 160, 0, size.width - 160 - radius, 0);

//     // Complete back to start
//     path.lineTo(radius, 0);

//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }


// Widget moduleSection(CourseProvider courseProvider) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Align(
//         alignment: Alignment(-0.9, 0),
//         child: Text("Course Module", style: AppTextStyles.heading),
//       ),
//       ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: courseProvider.modules.length,
//         itemBuilder: (context, index) {
//           final module = courseProvider.modules[index];
//           final isExpanded = _expandedModules.contains(index);

//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 // Main row with title and arrow
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(module.title, style: AppTextStyles.subHeading),
//                           AppSpacing.hsmall,
//                           Text(
//                             "${module.lessonCount} lessons · ${module.assignmentCount} assignments",
//                             style: AppTextStyles.body,
//                           ),
//                         ],
//                       ),
//                       Spacer(),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             if (isExpanded) {
//                               _expandedModules.remove(index);
//                             } else {
//                               _expandedModules.add(index);
//                             }
//                           });
//                         },
//                         icon: Icon(
//                           isExpanded
//                               ? Icons.arrow_drop_up
//                               : Icons.arrow_drop_down,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Expanded lessons list
//                 if (isExpanded)
//                   ...module.lessons.map((lesson) => Padding(
//                         padding:
//                             const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//                         child: Container(
//                           width: double.infinity,
//                           padding: EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: AppColors.primarygrey,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             lesson.title,
//                             style: AppTextStyles.body,
//                           ),
//                         ),
//                       )),
//               ],
//             ),
//           );
//         },
//       ),
//     ],
//   );
// }


@override
Widget build(BuildContext context) {
  final profileProvider = Provider.of<StudentProfile>(context);
  final profile = profileProvider.profile.isNotEmpty ? profileProvider.profile[0] : null;

  return Scaffold(
    body: profileProvider.isLoading
        ? Center(child: CircularProgressIndicator())
        : profile == null
            ? Center(child: Text("No profile data available"))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Profile Header
                    Container(
                      width: 300,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primarygrey,
                        border: Border.all(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primarygreen,
                            radius: 30,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(profile.name, style: AppTextStyles.subHeading),
                              Text("Student", style: AppTextStyles.body),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Profile Info Section
                    profile_information(profile),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false).studentLogout(context);
                      },
                      child: Text("Logout"),
                    ),
                  ],
                ),
              ),
  );
}



