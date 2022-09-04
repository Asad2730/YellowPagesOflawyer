import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer/other/Helper.dart';
import 'package:lawyer/Lawyer/add_info.dart';
import 'package:lawyer/widgets/my_widgets.dart';


class Personal extends StatefulWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  double? height,width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar:myAppBar(title: 'Personal', were: 'lawyerHome'),
        body: myContainer(width: width! * 0.05, widget: _buildUI()),
        drawer:myDrawer(),
      ),

    );
  }

  Widget _buildUI(){
    return SizedBox(
      height: height! * 0.90,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _listView(),
          _addInfo(),
        ],
      ),
    );
  }

  Widget _addInfo(){
    return  MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      minWidth: width! * 0.90,
      height: height! * 0.05,
      onPressed: ()=> Get.to(()=> const SavePersonal()),
      color: Colors.black,
      child:const Text(
        'Add Info',
        style:TextStyle(
          color: Colors.white,
         fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      ),
    );
  }

  Widget _listView(){
     return  ListView.builder(
         shrinkWrap: true,
         itemCount: Method.loggedUser.length,
         itemBuilder: (context,i){
           String url = Method.loggedUser[0].picture;
           return Card(
             child: ListTile(
               leading:SizedBox(width: 60,height: 60,child:myImages(url: url) ),
               title: Column(
                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Text('\n Email:${Method.loggedUser.elementAt(i).email}\n'),
                   Text('ContactNo:${Method.loggedUser.elementAt(i).contact} \n\nName:${Method.loggedUser.elementAt(i).fname+Method.loggedUser.elementAt(i).lname} \n\nGender:${Method.loggedUser.elementAt(i).gender}\n'
                   ),
                   Method.personalInfo.isNotEmpty?
                   Text('Office Address:${Method.personalInfo.elementAt(i).address}\n\nCity:${Method.personalInfo.elementAt(i).city}\n\nOffice No:${Method.personalInfo.elementAt(i).officeNo}\n\nEducation:${Method.personalInfo.elementAt(i).education}\n\n'
                   ):const Text('Office Address:Empty \n\n'
                       'City: Empty \n\n'
                       'Office No: Empty \n\n'
                       'Education: Empty \n'),
                 ],
               ),
             ),
           );
         });
  }
}
