import 'package:flutter/material.dart';
import 'package:lawyer/myNav.dart';
import 'package:lawyer/widgets/my_widgets.dart';



class LawyerHome extends StatefulWidget {
  const LawyerHome({Key? key}) : super(key: key);

  @override
  State<LawyerHome> createState() => _LawyerHomeState();
}

class _LawyerHomeState extends State<LawyerHome> {
  double? height,width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar:myAppBar(title: 'LawyerHome', were: 'login'),
       body: SafeArea(
         child:Container(
           padding: EdgeInsets.symmetric(horizontal: width! * 0.05),
           child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               mainAxisSize: MainAxisSize.max,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                _buildUI(),
               ],
             ),
           ),
         ),
       ),
        drawer: myDrawer(),
      ),
    );
  }

Widget _buildUI(){
  return SizedBox(
   height: height! * 0.40,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _myBtn(title: 'Personal', were: 'personal'),
        _myBtn(title: 'Expertise', were: 'expertise'),
        _myBtn(title: 'Cases', were: 'cases'),
        _myBtn(title: 'Practice', were: 'practice'),
     ],
 ),
  );
}

  Widget _myBtn({required String title,required String were}){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: ()=> myNav(were),
      minWidth: width! * 0.90,
      height: height! * 0.06,
      color: Colors.black,
      child:  Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }



}
