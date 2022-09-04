import 'package:get/get.dart';
import 'package:lawyer/Client/home.dart';
import 'package:lawyer/Lawyer/home.dart';
import 'package:lawyer/Lawyer/practice_tab.dart';
import 'package:lawyer/Lawyer/showAllCases.dart';
import 'package:lawyer/other/admin.dart';
import 'package:lawyer/other/login.dart';
import 'Lawyer/cases.dart';
import 'Lawyer/expertise.dart';
import 'Lawyer/personal.dart';


  void myNav(String were){
    switch(were){
      case 'login':{
        Get.to(()=> const Login());
       // Navigator.pop(context);
      }
      break;
      case 'personal':{
        Get.to(()=> const Personal());
      }
      break;
      case 'expertise':{
        Get.to(()=> const Expertise());
      }
      break;
      case 'cases':{
        Get.to(()=>const Cases());
      }
      break;
      case 'practice':{
        Get.to(()=> const PracticeTab());
      }
      break;
      case 'lawyerHome':{
        Get.to(()=>const LawyerHome());
      }
      break;
      case 'clientHome':{
        Get.to(()=>const ClientHome());
      }
      break;
      case 'admin':{
        Get.to(()=>const Admin());
      }
      break;
      case 'back':{
        Get.back();
      }
      break;

      case 'task':{
        Get.to(()=> const AllCases());
      }
      break;
      default: {
        //statements;
      }
      break;
    }


  }
