import 'package:flutter/material.dart';
import 'package:lawyer/Lawyer/clients.dart';
import 'package:lawyer/Lawyer/requests.dart';
import 'package:lawyer/Lawyer/view_clients.dart';
import 'package:lawyer/widgets/my_widgets.dart';


class Cases extends StatefulWidget {
  const Cases({Key? key}) : super(key: key);

  @override
  State<Cases> createState() => _CasesState();
}

class _CasesState extends State<Cases> {
  double? height,width;

  int currentPage = 0;
  var pages = [
     const ViewRequests(),
     const Clients(),
     const ViewClients(),
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: taskAppBar(),
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
          label: 'Requests',
          icon: Icon(Icons.request_page,),
        ),
        BottomNavigationBarItem(
          label: 'Clients',
          icon: Icon(Icons.person),
        ),

        BottomNavigationBarItem(
          label: 'ViewCases',
          icon: Icon(Icons.cases),
        ),

      ],
    );
  }

}
