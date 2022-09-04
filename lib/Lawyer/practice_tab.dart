import 'package:flutter/material.dart';
import 'package:lawyer/Lawyer/addPractice.dart';
import 'package:lawyer/Lawyer/view_practices.dart';
import '../widgets/my_widgets.dart';


class PracticeTab extends StatefulWidget {
  const PracticeTab({Key? key}) : super(key: key);

  @override
  State<PracticeTab> createState() => _PracticeTabState();
}

class _PracticeTabState extends State<PracticeTab> {
  double? height,width;

  int currentPage = 0;
  var pages = [
     const ViewPractices(),
     const AddPractice(),
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: myAppBar(title: '', were: 'lawyerHome'),
        bottomNavigationBar:_bottomNav() ,
        body:pages[currentPage],
        drawer:myDrawer(),
      ),
    );
  }

  Widget _bottomNav(){

    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap:(i){
        setState(() {
          currentPage = i;
        });
      } ,
      items:const [
        BottomNavigationBarItem(
          label: 'Practices',
          icon: Icon(Icons.request_page,),
        ),
        BottomNavigationBarItem(
          label: 'AddPractice',
          icon: Icon(Icons.person),
        ),

      ],
    );
  }


}
