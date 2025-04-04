import 'package:flutter/material.dart';

class Profilestudent extends StatefulWidget {
  const Profilestudent({super.key});

  @override
  State<Profilestudent> createState() => _ProfilestudentState();
}

class _ProfilestudentState extends State<Profilestudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 128),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Student Profile Page!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your button action here
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}