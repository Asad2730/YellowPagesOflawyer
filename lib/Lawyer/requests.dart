import 'package:flutter/material.dart';
import 'package:lawyer/other/Helper.dart';
import '../Db/db.dart';
import '../widgets/my_widgets.dart';


class ViewRequests extends StatefulWidget {
  const ViewRequests({Key? key}) : super(key: key);

  @override
  State<ViewRequests> createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {

  late Future _future;

  @override
  Widget build(BuildContext context) {
    _future = Db().loadRequests(status: 'pending');
    return _futureBuild();
  }

  Widget _futureBuild() {
    return FutureBuilder(
      future: _future,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //print(snapshot.data);
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context,i){
                Map data = snapshot.data[i];
                String url = data['picture'];
                return Card(
                  child: ListTile(
                    leading:SizedBox(width: 60,height: 60,child:myImages(url: url)),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10,),
                        Text('Name: ${data['name']}'),
                        Text('Email: ${data['email']}'),
                        Text('Contact: ${data['contact']}'),
                        Text('Case: ${data['type']}'),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: _acceptBtn(data)),
                            const SizedBox(width: 10,),
                            Expanded(child: _rejectBtn(data)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _acceptBtn(Map data){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: (){
        Db().changeRequestStatus(
            clientEmail:data['email'],
            lawyerEmail:Method.loggedUser.elementAt(0).email,
            status:'accept',
            type: data['type']);
        setState(() {});
      },
      color: Colors.black,
      child: const Text(
        'Accept',
        style:TextStyle(
          color: Colors.green,
        ) ,
      ),
    );
  }

  Widget _rejectBtn(Map data){

    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: (){
        Db().changeRequestStatus(
            clientEmail:data['email'],
            lawyerEmail:Method.loggedUser.elementAt(0).email,
            status:'reject',
             type: data['type']
        );
        setState(() { });
      },
      color: Colors.black,
      child: const Text('Reject',
        style:TextStyle(
          color: Colors.red,
        ) ,
      ),
    );
  }

}
