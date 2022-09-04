import 'package:flutter/material.dart';
import 'package:lawyer/Db/db.dart';

class ViewPractices extends StatefulWidget {
  const ViewPractices({Key? key}) : super(key: key);

  @override
  State<ViewPractices> createState() => _ViewPracticesState();
}

class _ViewPracticesState extends State<ViewPractices> {

  late Future _future;

  @override
  void initState(){
    super.initState();
    _future = Db().getPractice();
  }

  @override
  Widget build(BuildContext context) {
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


  Widget _list(AsyncSnapshot snapshot){

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:snapshot.data.length,
        itemBuilder: (context,i){
          Map data = snapshot.data[i];
          return Card(
            child: ListTile(
              title:Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height:10 ,),
                  Text('City : ${data['city']}'),
                  const SizedBox(height:10 ,),
                  Text('Court : ${data['court']}'),
                  const SizedBox(height:20 ,),
                  Text('To : ${data['to']}'),
                  const SizedBox(height:20 ,),
                  Text('From : ${data['from']}' ),
                  const SizedBox(height:20 ,),
                ],
              ),
            ),
          );
        }) ;
  }


}

