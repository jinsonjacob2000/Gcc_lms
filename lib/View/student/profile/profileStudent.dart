import 'package:flutter/material.dart';
import 'package:portfolio_lms/Models/profileModel/get_profile.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/View/student/profile/dialogData.dart';
import 'package:portfolio_lms/Viewmodel/Authentication/auth_provider.dart';
import 'package:portfolio_lms/Viewmodel/student_provider/student_profile.dart';
import 'package:provider/provider.dart';

class Profilestudent extends StatefulWidget {
  const Profilestudent({super.key});

  @override
  State<Profilestudent> createState() => _ProfilestudentState();
}

TextEditingController namecontroller = TextEditingController();
TextEditingController emailcontroler = TextEditingController();
TextEditingController phonecontroller = TextEditingController();

class _ProfilestudentState extends State<Profilestudent> {
  // ✅ Keep only this one
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<StudentProfile>(context);
    final profile = profileProvider.profile;

    print(profile?.name);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (profileProvider.isLoading)
                Center(child: CircularProgressIndicator())
              else if (profileProvider.error != null)
                Column(
                  children: [
                    Text(
                      "Error: ${profileProvider.error}",
                      style: AppTextStyles.subHeading,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        ).studentLogout(context);
                      },
                      child: Text("Logout"),
                    ),
                  ],
                )
              else if (profile == null)
                Column(
                  children: [
                    Text("No profile data available"),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        ).studentLogout(context);
                      },
                      child: Text("Logout"),
                    ),
                  ],
                )
              else
                Expanded(
                  child: Column(
                    children: [
                      // Your normal profile UI
                      // header + profile_information(profile)
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
                                Text(
                                  profile.name,
                                  style: AppTextStyles.subHeading,
                                ),
                                Text(profile.role, style: AppTextStyles.body),
                              ],
                            ),
                          ],
                        ),
                      ),
                      profile_information(profile),
                      SizedBox(height: 20),
                      InkWell(
                        enableFeedback: false,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return updatePersonalinfo(
                                context,
                                "Edit Personal Information",
                                profile,
                                profileProvider,
                              );
                            },
                          );
                        },
                        child: buttonContainer("Edit Personal information"),
                      ),
                      AppSpacing.hsmall,
                      InkWell(
                        enableFeedback: false,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return leaveDialogueBox(
                                context,
                                // profile,
                                // profileProvider,
                              );
                            },
                          );
                        },
                        child: buttonContainer("Leave management"),
                      ),
                      AppSpacing.hsmall,
                      InkWell(
                        enableFeedback: false,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return attendanceBox(
                                context,
                                // profile,
                                // profileProvider,
                              );
                            },
                          );
                        },
                        child: buttonContainer("View Attendance"),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          ).studentLogout(context);
                        },
                        child: Text("Logout"),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profile_information(Profile profile) {
    return Column(
      children: [
        AppSpacing.hsmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("personal information", style: AppTextStyles.subHeading),
          ],
        ),
        AppSpacing.hsmall,
        Container(
          margin: EdgeInsets.only(
            left: 15.0,
            top: 20.0,
            right: 15.0,
            bottom: 3.0,
          ),

          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primarygrey, // ✅ Moved color here
            border: Border.all(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.email, // 👤 You can change this icon
                size: 40,
                color: Colors.blue,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("email", style: AppTextStyles.subHeading),
                  Text(profile.email, style: AppTextStyles.body),
                ],
              ),
            ],
          ),
        ),
        AppSpacing.hsmall,
        Container(
          margin: EdgeInsets.only(
            left: 15.0,
            top: 20.0,
            right: 15.0,
            bottom: 3.0,
          ),

          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primarygrey, // ✅ Moved color here
            border: Border.all(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.phone, // 👤 You can change this icon
                size: 40,
                color: Colors.blue,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone", style: AppTextStyles.subHeading),
                  Text(profile.phoneNumber, style: AppTextStyles.body),
                ],
              ),
            ],
          ),
        ),
        AppSpacing.hsmall,

        Container(
          margin: EdgeInsets.only(
            left: 15.0,
            top: 20.0,
            right: 15.0,
            bottom: 3.0,
          ),

          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primarygrey, // ✅ Moved color here
            border: Border.all(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.phone, // 👤 You can change this icon
                size: 40,
                color: Colors.blue,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Registration Id", style: AppTextStyles.subHeading),
                  Text(profile.registrationId, style: AppTextStyles.body),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buttonContainer(String buttontext) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 15.0, top: 20.0, right: 15.0, bottom: 3.0),

      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primarygreen,
      ),
      child: Center(child: Text(buttontext, style: AppTextStyles.subwhite)),
    );
  }

  Widget updatePersonalinfo(
    BuildContext context,
    String title,
    Profile profile,
    StudentProfile profileProvider,
  ) {
    namecontroller.text = profile.name ?? ''; // Set profile data to controller
    emailcontroler.text = profile.email ?? '';
    phonecontroller.text = profile.phoneNumber ?? '';

    return AlertDialog(
      title: Text(title),
      content: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: namecontroller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined),
                labelText: "Firstname",
                border: OutlineInputBorder(),
              ),
            ),
            AppSpacing.hsmall,
            TextFormField(
              controller: emailcontroler,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: "Email Address",
                border: OutlineInputBorder(),
              ),
            ),
            AppSpacing.hsmall,
            TextFormField(
              controller: phonecontroller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle submit logic here
                profileProvider.updateProfile(
                  namecontroller.text,
                  emailcontroler.text,
                  phonecontroller.text,
                );
                // profileProvider.Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  Widget leaveDialogueBox(
    BuildContext context,
    // Profile profile,
    // StudentProfile profileProvider,
  ) {
    return AlertDialog(
      content: DefaultTabController(
        length: 2,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Medical Leave",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(Icons.close, color: Colors.grey[600], size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.green,
                tabs: [Tab(text: "Apply Leave"), Tab(text: "Leave History")],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300, // You can adjust height as needed
                child: TabBarView(
                  children: [
                    Center(child: ApplyLeaveForm()),
                    Center(child: LeaveHistoryScreen()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget attendanceBox(
    BuildContext context,
  
  ) {
    return AlertDialog(
      content: DefaultTabController(
        length: 2,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Attendance",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(Icons.close, color: Colors.grey[600], size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.green,
                tabs: [Tab(text: "View Attendance"), Tab(text: "Mark Attendance")],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300, // You can adjust height as needed
                child: TabBarView(
                  children: [
                    Center(child: ViewAttendanceWidget()),
                    Center(child: SendAttendanceWidget()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
