// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Future.microtask(() {
//       final authprovider = Provider.of<adminprovider>(context, listen: false);
//       authprovider.Adminautologin(context);
//     });
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//               width: 360, child: Center(child: CircularProgressIndicator())),
//         ],
//       ),
//     );
//   }
// }