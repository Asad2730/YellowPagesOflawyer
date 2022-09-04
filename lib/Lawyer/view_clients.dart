import 'package:flutter/material.dart';
import 'package:lawyer/widgets/my_widgets.dart';
import '../Db/db.dart';



class ViewClients extends StatefulWidget {
  const ViewClients({Key? key}) : super(key: key);

  @override
  State<ViewClients> createState() => _ViewClientsState();
}

class _ViewClientsState extends State<ViewClients> {

  late Future _future;
  double? height,width;

  @override
  void initState()  {
    super.initState();
    _future = Db().getLawyerClients();
  }


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return _clients();
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
                    Text('Date : ${data['date']}'),
                    const SizedBox(height:10 ,),
                    Text('Status : ${data['status']}'),
                    const SizedBox(height:10 ,),
                    data['rate']=="0"? _finishBtn(data['id']):const Text(''),
                    const SizedBox(height:20 ,),
                  ],
                ),
              ),
            );
          }),
    ) ;
  }

  Widget _finishBtn(int id){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: ()=>showImageDialog(id),
      minWidth: width! * 0.30,
      height: height! * 0.05,
      color: Colors.black,
      child:  const Text(
        'Close Case',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }



  Future<void> showImageDialog(int id) async {

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option!'),
          content: Row(
            children: <Widget>[
              TextButton(onPressed: (){
                Db().closeCase(id: id,result: 'won');
                Navigator.pop(context);
                setState((){});
              }, child: const Text(
                'Won',
                style: TextStyle(color:Colors.green ),
              ),
              ),
              TextButton(onPressed: (){
                Db().closeCase(id: id,result: 'lost');
                Navigator.pop(context);
                setState((){});
              }, child: const Text('Lost',
                style: TextStyle(color:Colors.red ),
              ),
              ),
            ],
          ),
        );
      },
    );
  }

}
