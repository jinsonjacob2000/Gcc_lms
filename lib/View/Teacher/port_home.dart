import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio_lms/Utilities/Constants.dart';
import 'package:portfolio_lms/View/student/profile/profileStudent.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PortHome extends StatefulWidget {
  const PortHome({super.key});

  @override
  State<PortHome> createState() => _HomeStudentState();
}

class _HomeStudentState extends State<PortHome> {
  int _currentCommunityIndex = 0;

  final List<Map<String, dynamic>> _communityItems = [
    {
      'title': 'WHATSAPP COMMUNITY',
      'description': 'Grow and connect with UIUX and coding experts.',
      'color': const Color(0xFF5EE085),
      'icon': 'assets/whatsapp.png',
    },
    {
      'title': 'DISCORD COMMUNITY',
      'description': 'Grow and connect with coding experts.',
      'color': const Color(0xFF7289DA),
      'icon': 'assets/discord.png',
    },
    {
      'title': 'TELEGRAM GROUP',
      'description': 'Join our developer community.',
      'color': const Color(0xFF0088CC),
      'icon': 'assets/telegram.png',
    },
  ];

  final List<Map<String, String>> jobData = [
    {
      "title": "Node.js Developer",
      "company": "LumionoGuru Pvt Ltd",
      "location": "Mohali",
      "type": "Job",
      "logo":
          "https://w7.pngwing.com/pngs/788/651/png-transparent-code-development-logo-nodejs-logos-icon-thumbnail.png", // Replace with real logo URL
    },
    {
      "title": "Flutter Intern",
      "company": "TechCrew Ltd",
      "location": "Bangalore",
      "type": "Internship",
      "logo": "https://img.icons8.com/color/512/flutter.png",
    },
    {
      "title": "UI/UX Designer",
      "company": "Designly Inc.",
      "location": "Remote",
      "type": "Job",
      "logo":
          "https://i.pinimg.com/736x/74/13/eb/7413eb389b7360e1c6f96a8114995989.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appTheme,
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   backgroundColor: const Color.fromARGB(255, 0, 0, 128),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Student Profile details
                studentProfile(),

                AppSpacing.hlarge,

                // Community Details
                communityHeaders(),

                AppSpacing.hlarge,

                Row(
                  children: [
                    AppSpacing.smallWidth,
                    Text(
                      "Recently Added Jobs",
                      style: AppTextStyles.largewhite,
                    ),
                  ],
                ),

                AppSpacing.hlarge,

                // recently added
                recentlyAdded(),

                AppSpacing.hlarge,

                //Explore
                Explore(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget studentProfile() {
    return Container(
      height: 100,
      width: double.infinity,
      color: AppColors.appTheme,

      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D', // Replace with your image URL
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Student Name', style: AppTextStyles.subwhite),
                Text('Student ID', style: AppTextStyles.subwhite),
              ],
            ),
          ),
          Spacer(),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primarygrey,
            child: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          ),
          SizedBox(width: 10),

          CircleAvatar(
            backgroundColor: AppColors.primarygrey,
            child: IconButton(
              icon: const Icon(Icons.notifications_on_outlined),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget communityHeaders() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            viewportFraction: 0.85,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCommunityIndex = index;
              });
            },
          ),
          items:
              _communityItems.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: item['color'],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: ClipOval(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        item['icon'],
                                        width: 24,
                                        height: 24,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(
                                                  Icons.group,
                                                  color: item['color'],
                                                ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              item['description'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Joining ${item['title']}"),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Join',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              _communityItems.asMap().entries.map((entry) {
                return Container(
                  width: entry.key == _currentCommunityIndex ? 20.0 : 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:
                        entry.key == _currentCommunityIndex
                            ? const Color(0xFF5EE085)
                            : Colors.grey,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget recentlyAdded() {
    return CarouselSlider.builder(
      itemCount: jobData.length,
      options: CarouselOptions(
        height: 170,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      itemBuilder: (context, index, realIdx) {
        final job = jobData[index];

        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1B1E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.greenAccent.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          job["logo"]!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job["title"]!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              job["company"]!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.bookmark_border, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Row(
                    children: [
                      jobTag(job["type"]!),
                      const SizedBox(width: 8),
                      jobTag(
                        job["location"]!,
                        icon: Icons.location_on_outlined,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget jobTag(String label, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.white70, size: 16),
          if (icon != null) const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget Explore() {
    return Container(width:400,
    height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage("assets/images/explore.png"),fit: BoxFit.fitWidth),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(2)
              ),

              backgroundColor: AppColors.primarygreen,
            ),
            onPressed: () {},
            child: Text("Enroll Now"),
          ),
        ],
      ),
    );
  }
}
