import 'package:flutter/material.dart';
import 'package:lawyer/Db/db.dart';
import 'package:lawyer/widgets/my_widgets.dart';

class ClientNotifications extends StatefulWidget {
  const ClientNotifications({Key? key}) : super(key: key);

  @override
  State<ClientNotifications> createState() => _ClientNotificationsState();
}

class _ClientNotificationsState extends State<ClientNotifications> {

  late Future _future;
  @override
  Widget build(BuildContext context) {
    _future = Db().clientNotification();
    return MaterialApp(
      home: Scaffold(
        appBar: myAppBar(title: 'Notifications', were: 'back'),
        body: SafeArea(child: _futureBuilder()),
        drawer: myClientDrawer(),
      ),
    );
  }


  Widget _futureBuilder(){
    
    return FutureBuilder(
        future:_future ,
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return _list(snapshot);

          }else{
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  Widget _list(AsyncSnapshot snapshot){

    return ListView.builder(
       shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:snapshot.data.length,
      itemBuilder: (context,i){
         Map data = snapshot.data[i];
         String msg = 'Your request for ${data['type']} on ${data['date']} is ${data['status'].toString().trim()}ed.';
         return Padding(
           padding: const EdgeInsets.fromLTRB(1, 10, 5, 10),
           child: Card(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
             child:_txt(msg),
           ),
         );
      }
    );

  }

  Widget _txt(String txt){
    return Text(txt,
      style:const TextStyle(
        fontSize: 16,
        color:Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }


}
