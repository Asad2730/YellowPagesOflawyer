import 'package:flutter/material.dart';
import 'package:lawyer/other/login.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       home: const Scaffold(
         body:Login(),
       ),
       navigatorKey: Get.key,
     );
   }
}
