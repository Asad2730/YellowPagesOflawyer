import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lawyer/Db/db.dart';
import 'package:lawyer/other/Helper.dart';
import 'package:lawyer/widgets/my_widgets.dart';



class ClientHome extends StatefulWidget {
  const ClientHome({Key? key}) : super(key: key);

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {

  double? height,width;
  late Future _future;
  String? type;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _future = Db().searchLawyer(type: type == null?'':type!);
    return MaterialApp(
      home: Scaffold(
       appBar: myAppBar(title: 'Client Home', were: 'login'),
        body:myContainer(width: width! * 0.05, widget: _buildUI()),
        drawer: myClientDrawer(),
      ),
    );
  }

  Widget _buildUI(){
    return SizedBox(
      height: height! * 0.80,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            caseTypes(),
           const SizedBox(height: 20,),
          _futureList(),
        ],
      ),
    );
  }

  Widget caseTypes(){

    var items = Method.lawyerTypes.map<DropdownMenuItem<String>>((value) {
      return DropdownMenuItem(
        value: value,
        child: Text(value),
      );
    }).toList();

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      hint: const Text('select case type'),
      value: type,
      validator:(v)=>v!.isNotEmpty?null:'please select case type',
      onChanged: (String? v){
        setState(() {
           type = v;
        });
      },
      items: items,
    );
  }

  Widget _futureList(){
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
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context,i){
            Map data = snapshot.data[i];
            String url = snapshot.data[i]['picture'];
            int totalCases = int.parse(data['won'])+int.parse(data['loss']);
            return Card(
              child: ListTile(
                leading: myImages(url: url),
                title: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _txt('Name ',data['name']),
                    _txt('Contact ',data['contact']),
                    _txt('Email ',data['email']),
                    _txt('Address ',data['address']),
                    _txt('OfficeNo',data['officeNo']),
                    _txt('TotalCases',totalCases.toString()),
                    _txt('WinPercentage ',data['percentage']+'%'),
                    const SizedBox(height: 5,),
                    data['rating'] != 0?_rating(data['rating']):const Text(''),
                    const SizedBox(height: 5,),
                     _hireLawyerBtn(data),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            );
          }),
    );

  }



  Widget _txt(String title,String data){
    return Text(
      '$title: $data',
      style:const TextStyle(
        fontSize: 16,
        color:Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }


  Widget _hireLawyerBtn(Map data){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: ()=> _sendRequest(data),
      minWidth: width! * 0.40,
      height: height! * 0.05,
      color: Colors.black,
      child: const Text(
        'Hire Lawyer',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }


  Widget _rating(double rate){
    return RatingBarIndicator(
      rating: rate,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: width! * 0.08,
      direction: Axis.horizontal,
    );

  }


  void _sendRequest(Map data){
    Db().sendRequest(
      clientEmail:Method.loggedUser.elementAt(0).email,
      lawyerEmail:data['email'],
      status:'pending',
      type:type!,
    );
  }

}
