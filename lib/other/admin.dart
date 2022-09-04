import 'package:flutter/material.dart';
import 'package:lawyer/Db/db.dart';
import 'package:lawyer/widgets/my_widgets.dart';



class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  late Future _future;
  double? height,width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _future = Db().loadAdmin();
    return MaterialApp(
      home:Scaffold(
        appBar:myAppBar(title: 'Admin', were: 'login'),
        body:SafeArea(
          child: _futureList(),
        ),
        drawer: myDrawer(),
      ),
    );
  }
  Widget _futureList(){

    return FutureBuilder(
        future:_future ,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return _list(snapshot);
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }
    );
  }


  Widget _list(AsyncSnapshot snapshot){
    return SingleChildScrollView(
      child:Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context,i) {
                Map data = snapshot.data[i];
                String url = snapshot.data[i]['picture'];
                return Card(
                  child: ListTile(
                     leading:  SizedBox(width: 60,height: 60,child:myImages(url: url)),
                    title: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10,),
                        _dataTxt(title:'Name', data: data['fName']+' '+data['lName']),
                        _dataTxt(title: 'Type', data: data['type']),
                        _dataTxt(title: 'Email', data: data['email']),
                         const SizedBox(height: 5,),
                        _mYBtn(email: data['email'], status: data['status']),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                );
              }
          ),
        ],
      ),
    );
  }


  Widget _dataTxt({required String title,required String data}){
    return  Text(
      '$title : $data',
      style:const TextStyle(
        fontSize: 18,
        color:Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }


  Widget _mYBtn({required String email,required String status}){

     return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: (){
        setState(() {
          Db().changeUserStatus(email:email);
        });
      },
      minWidth: width! * 0.40,
      height: height! * 0.04,
      color: Colors.black,
      child:  Text(
        status,
        style:  const TextStyle(
          color:Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }



}
