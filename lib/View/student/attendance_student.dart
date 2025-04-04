import 'package:flutter/material.dart';

class AttendanceStudent extends StatefulWidget {
  const AttendanceStudent({super.key});

  @override
  State<AttendanceStudent> createState() => _AttendanceStudentstate();
}

class _AttendanceStudentstate extends State<AttendanceStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 128),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Student Contacts Page!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your button action here
              },
              child: const Text('Contact Support'),
            ),
          ],
        ),
      ),
    );
  }
}