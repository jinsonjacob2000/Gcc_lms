import 'package:flutter/material.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/View/commons/common_widgets.dart';
import 'package:portfolio_lms/Viewmodel/student_provider/studentCourse.dart';
import 'package:provider/provider.dart';

class Mycoursepage extends StatefulWidget {
  final int courseId;
  const Mycoursepage({super.key, required this.courseId});

  @override
  State<Mycoursepage> createState() => _StudentcourseState();
}

class _StudentcourseState extends State<Mycoursepage> {
  // Track expanded modules
  Set<int> _expandedModules = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final courseProvider = Provider.of<CourseProvider>(
        context,
        listen: false,
      );
      courseProvider.getModules(widget.courseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primarygrey,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomAppbar(titleText: "My Courses"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Live session
              liveSession(),

              AppSpacing.hlarge,

              // Course Modules
              moduleSection(courseProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget liveSession() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Live Sessions", style: AppTextStyles.heading),
          AppSpacing.hsmall,
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.secondaryBlack, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.live_tv_sharp,
                    color: AppColors.primaryRed,
                    size: 40,
                  ),
                  Spacer(),
                  Text(
                    "No live sessions available \ncheck back later for upcoming live session",
                    style: AppTextStyles.subHeading,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget moduleSection(CourseProvider courseProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Course Modules", style: AppTextStyles.heading),
          AppSpacing.hmedium,
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: courseProvider.modules.length,
            itemBuilder: (context, index) {
              final module = courseProvider.modules[index];
              final isExpanded = _expandedModules.contains(index);

              return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // Module Title and Expand Button
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                module.title,
                                style: AppTextStyles.subHeading,
                              ),
                              AppSpacing.hsmall,
                              Text(
                                // "${module.lessonCount} lessons · ${module.assignmentCount} assignments",
                                "ggwehwejj",
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
  onPressed: () async {
    final lessonProvider =
        Provider.of<CourseProvider>(context, listen: false);

    // If expanding, fetch lessons
    if (!isExpanded) {
      // await lessonProvider.getLessonProvider(,module.moduleId);
    }

    // Toggle expansion
    setState(() {
      if (isExpanded) {
        _expandedModules.remove(index);
      } else {
        _expandedModules.add(index);
      }
    });
  },
  icon: Icon(
    isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
  ),
),

                        ],
                      ),
                    ),

                    // Lesson List
                    if (isExpanded)
                      // ...module.lessons.map(
                      //   (lesson) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),

                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primarygrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "wekfkwldkfw",
                                    style: AppTextStyles.body,
                                  ),
                                  AppSpacing.hsmall,
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primarygreen
                                    ),
                                    onPressed: () {},
                                    icon: Icon(Icons.play_circle_outline_sharp,color: AppColors.primarywhite,),
                                    label: Text("Watch Lesson",style: AppTextStyles.subwhite,),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    // ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
