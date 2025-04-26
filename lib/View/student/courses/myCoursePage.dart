import 'package:flutter/material.dart';
import 'package:portfolio_lms/Models/coursesModel/get_lesson.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/View/commons/common_widgets.dart';
import 'package:portfolio_lms/View/student/courses/videoPlayer.dart';
import 'package:portfolio_lms/Viewmodel/student_provider/studentCourse.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Mycoursepage extends StatefulWidget {
  final int courseId;
  final int batchId;
  const Mycoursepage({
    super.key,
    required this.courseId,
    required this.batchId,
  });

  @override
  State<Mycoursepage> createState() => _StudentcourseState();
}

class _StudentcourseState extends State<Mycoursepage> {
  // Track expanded modules
  Set<int> _expandedModules = {};

  String formatLiveTime(String isoTime) {
    try {
      final time = DateTime.parse(isoTime).toLocal();

      // Format date: March 3, 2025
      final date = "${_monthName(time.month)} ${time.day}, ${time.year}";

      // Format time: 10:00 AM
      final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
      final minute = time.minute.toString().padLeft(2, '0');
      final period = time.hour >= 12 ? 'PM' : 'AM';

      final formattedTime = "$hour:$minute $period";

      return "$date · $formattedTime";
    } catch (e) {
      return "Invalid time";
    }
  }

  // Helper for month names
  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final courseProvider = Provider.of<CourseProvider>(
        context,
        listen: false,
      );
      await courseProvider.getModules(widget.courseId);
      await courseProvider.getLiveProvider(widget.courseId, widget.batchId);
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
              liveSession(courseProvider),

              AppSpacing.hlarge,

              // Course Modules
              moduleSection(courseProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget liveSession(CourseProvider courseProvider) {
    final livelinkss = courseProvider.livelinks;

    if (courseProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return courseProvider.livelinks.isEmpty
        ? noLink()
        : Padding(
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
                      AppSpacing.mediumWidth,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Live starts at :",
                            style: AppTextStyles.subHeading,
                          ),
                          Text(
                            livelinkss.isNotEmpty
                                ? formatLiveTime(
                                  livelinkss.first.liveStartTime.toString(),
                                )
                                : "No start time",
                            style: AppTextStyles.body,
                          ),
                        ],
                      ),
                      AppSpacing.largeWidth,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primarygreen,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            String url =
                                courseProvider.livelinks.first.liveLink!;

                            // Ensure URL has proper scheme
                            if (!url.startsWith("http")) {
                              url = "https://$url";
                            }

                            final uri = Uri.parse(url);

                            final bool launched = await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );

                            if (!launched) {
                              throw 'Could not launch';
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Could not open the live session link",
                                ),
                              ),
                            );
                          }
                        },

                        child: Text("Join Now", style: AppTextStyles.subwhite),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }

  Widget noLink() {
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
    final lessonProvider = Provider.of<CourseProvider>(context, listen: false);

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
                              // Text(
                              //   // "${module.lessonCount} lessons · ${module.assignmentCount} assignments",
                              //   "ggwehwejj",
                              //   style: AppTextStyles.body,
                              // ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              // Call both provider methods here
                              await lessonProvider.getLessonProvider(
                                widget.courseId,
                                module.moduleId,
                              );

                              // 👉 Example: Another provider method call
                              await lessonProvider.getAssignmentProvider(
                                widget.courseId,
                                module.moduleId,
                              );

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
                              isExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
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
                        child:
                            courseProvider.isLoading == true
                                ? CircularProgressIndicator()
                                : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),

                                  itemCount: courseProvider.lessons.length,
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
                                            courseProvider.lessons[index].title,
                                            style: AppTextStyles.subHeading,
                                          ),
                                          AppSpacing.hsmall,
                                          Text(
                                            courseProvider
                                                .lessons[index]
                                                .content,
                                            style: AppTextStyles.body,
                                          ),
                                          AppSpacing.hsmall,

                                          // Check if there is a video link to display
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.primarygreen,
                                            ),
                                            onPressed: () {
                                              String? url =
                                                  courseProvider
                                                      .lessons[index]
                                                      .videoLink;
                                              if (url != null) {
                                                print("Video URL: $url");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            VideoPlayerScreen(
                                                              url: url,
                                                            ),
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "Live session link is unavailable.",
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            icon: Icon(
                                              Icons.play_circle_outline_sharp,
                                              color: AppColors.primarywhite,
                                            ),
                                            label: Text(
                                              "Watch Lesson",
                                              style: AppTextStyles.subwhite,
                                            ),
                                          ),

                                          // Show PDF icon if pdfPath is available
                                          if (courseProvider
                                                  .lessons[index]
                                                  .pdfPath !=
                                              null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                              ),
                                              child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.primaryblue,
                                                ),
                                                onPressed: () {
                                                  String? pdfUrl =
                                                      courseProvider
                                                          .lessons[index]
                                                          .pdfPath;
                                                  if (pdfUrl != null) {
                                                    // Open the PDF link (use your desired PDF viewer or browser)
                                                    print(
                                                      "Opening PDF: $pdfUrl",
                                                    );
                                                    // You can use the url_launcher plugin to open the PDF link in a browser
                                                    launch(
                                                      pdfUrl,
                                                    ); // Ensure you have url_launcher added to your pubspec.yaml
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          "PDF link is unavailable.",
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.picture_as_pdf,
                                                  color: AppColors.primarywhite,
                                                ),
                                                label: Text(
                                                  "Read PDF",
                                                  style: AppTextStyles.subwhite,
                                                ),
                                              ),
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
