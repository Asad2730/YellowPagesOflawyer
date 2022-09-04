import 'package:flutter/material.dart';
import 'package:lawyer/Db/db.dart';
import 'package:lawyer/widgets/my_widgets.dart';



class ViewExpertise extends StatefulWidget {
  const ViewExpertise({Key? key}) : super(key: key);

  @override
  State<ViewExpertise> createState() => _ViewExpertiseState();
}

class _ViewExpertiseState extends State<ViewExpertise> {

  double? height,width;
  late Future _future;
  @override
  void initState() {
    super.initState();
    _future = Db().viewExpertise();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
       appBar: myAppBar(title: 'View Expertise', were: 'expertise'),
        body:_futureList(),
          drawer: myDrawer(),
        ),
    );
  }

  Widget _futureList(){

    return FutureBuilder(
        future:_future ,
        builder: (context,snapshot){
           if(snapshot.hasData){
              return listView(snapshot);
           }else{
             return const Center(child: CircularProgressIndicator(),);
           }
        }
    );
  }

  Widget listView(AsyncSnapshot snapshot) {
    return  SafeArea(
      child: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context,i){
              Map data = snapshot.data[i];
              return Card(
                child: ListTile(
                  title: _subTitle(data),
                ),
              );
            },
            ),
      ),
    );
  }

  Widget _subTitle(Map data){
    return SizedBox(
      height: height! * 0.10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           const SizedBox(height: 10,),
           Text('Type: ${data['type']}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
          const SizedBox(height: 5,),
          Text('TotalCases: ${data['total']}'),
          Text('WinPercentage: ${data['percentage']}%'),
        ],
      ),
    );
  }
  

}
