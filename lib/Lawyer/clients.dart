import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer/Lawyer/add_client_cases.dart';
import 'package:lawyer/widgets/my_widgets.dart';
import '../Db/db.dart';


class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);
  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {

  late Future _future;

  @override
  Widget build(BuildContext context) {
    _future = Db().loadRequests(status: 'accept');
    return _futureBuild();
  }

  Widget _futureBuild(){
    return FutureBuilder(
      future:_future ,
      builder:(context,AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return _list(snapshot);

        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

 Widget _list(AsyncSnapshot snapshot){

  return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:snapshot.data.length,
      itemBuilder: (context,i){
        Map data = snapshot.data[i];
        String url = snapshot.data[i]['picture'];
        return Card(
          child: ListTile(
            leading: myImages(url: url),
            title:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height:10 ,),
                Text('Name : ${data['name']}'),
                const SizedBox(height:10 ,),
                Text('Case : ${data['type']}'),
                const SizedBox(height:20 ,),
              ],
            ),
            trailing:_addBtn(data),
          ),
        );
      }) ;
 }


 Widget _addBtn(Map map){

  return MaterialButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
      onPressed: ()=> Get.to(()=> AddClientCase(clientEmail:map['email'] ,type:map['type'])),
       color: Colors.black,
       child: const Text(
         'Add Case',
       style:TextStyle(
         color: Colors.white,
       ) ,
       ),
  );

}
