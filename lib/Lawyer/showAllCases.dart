import 'package:flutter/material.dart';
import 'package:lawyer/Db/db.dart';

import '../widgets/my_widgets.dart';

class AllCases extends StatefulWidget {
  const AllCases({Key? key}) : super(key: key);

  @override
  State<AllCases> createState() => _AllCasesState();
}

class _AllCasesState extends State<AllCases> {
  late Future _future;
  double? height,width;

  @override
  Widget build(BuildContext context) {
    _future = Db().showAll();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: taskAppBar(),
         body: _clients(),
      ),
    );
  }

  Widget _clients(){

    return FutureBuilder(
      future: _future,
      builder: (context,snapshot){
        //print(snapshot.data);
        if(snapshot.hasData){
          return _list(snapshot);
        }else{
          return const Center(child:CircularProgressIndicator(),);
        }
      },
    );

  }


  Widget _list(AsyncSnapshot snapshot){
    return SingleChildScrollView(
      child: ListView.builder(
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
                    Text('Email : ${data['email']}'),
                    const SizedBox(height:10 ,),
                    Text('Case : ${data['type']}'),
                    const SizedBox(height:10 ,),
                    Text('City : ${data['city']}'),
                    const SizedBox(height:10 ,),
                    Text('Status : ${data['court']}'),
                    const SizedBox(height:10 ,),
                    Text('Status : ${data['status']}'),
                    const SizedBox(height:20 ,),
                  ],
                ),
              ),
            );
          }),
    ) ;
  }

}


