import 'package:flutter/material.dart';

class SupportStudent extends StatefulWidget {
  const SupportStudent({super.key});

  @override
  State<SupportStudent> createState() => _SupportStudentState();
}

class _SupportStudentState extends State<SupportStudent> {

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 128),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Student Support Page!',
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