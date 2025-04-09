
import 'package:flutter/material.dart';
import 'package:portfolio_lms/Viewmodel/Authentication/auth_provider.dart';
import 'package:provider/provider.dart';

class Profilestudent extends StatefulWidget {
  const Profilestudent({super.key});

  @override
  State<Profilestudent> createState() => _ProfilestudentState();
}

class _ProfilestudentState extends State<Profilestudent> {
  
 
@override
  Widget build(BuildContext context) {
    
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile'),
      //   backgroundColor: const Color.fromARGB(255, 0, 0, 128),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                children: [
                  ElevatedButton(onPressed:(){
                    Provider.of<AuthProvider>(context, listen: false).studentLogout(context);
                  } , child:Text("logout"))
                ],
              ),
            )
      
          ],
        ),
      ),
    );
  }
}