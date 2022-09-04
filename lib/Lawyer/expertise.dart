import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer/Db/db.dart';
import 'package:lawyer/Lawyer/viewExpertise.dart';
import 'package:lawyer/other/Helper.dart';
import '../widgets/my_widgets.dart';




class Expertise extends StatefulWidget {
  const Expertise({Key? key}) : super(key: key);

  @override
  State<Expertise> createState() => _ExpertiseState();
}

class _ExpertiseState extends State<Expertise> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? totalCases,casesWon,type;
  double? height,width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: myAppBar(title: 'Expertise', were: 'lawyerHome'),
        body:myContainer(width: width! * 0.05, widget: _buildUI()),
        drawer: myDrawer(),
      ),
    );
  }

  Widget _buildUI(){
    return SizedBox(
      height: height! * 0.50,
      child: Form(
        key: _formKey,
        child:Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             _total(),
            _won(),
            _types(),
             _expertiseBtn(),
             _addBtn(),
          ],
        ) ,
      ),
    );
  }


  Widget _total(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration:  InputDecoration(
        hintText:'TotalCases...',
        contentPadding:  const EdgeInsets.all(15),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onSaved: (v){
        setState(() {
          totalCases = v!;
        });
      },
      validator:(v)=>v!.isNotEmpty?null:'please enter no of cases!',
    );
  }


  Widget _won(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration:  InputDecoration(
        hintText:'Won...',
        contentPadding:  const EdgeInsets.all(15),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onSaved: (v){
        setState(() {
          casesWon = v!;
        });
      },
      validator:(v)=>v!.isNotEmpty?null:'please enter no of cases won!',
    );
  }


  Widget _types(){

    var items = Method.lawyerTypes.map((e){
      return DropdownMenuItem(value: e,child: Text(e),);
    }).toList();

    return DropdownButtonFormField(
      hint: const Text('CaseType...'),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          )
      ),
      //value: type,
      validator:(v)=>v == null?'please select case type':null,
      onChanged: (String ? v)=>setState(() { type = v!;}),
      items: items,
    );

  }


  Widget _expertiseBtn(){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: ()=> Get.to(()=> const ViewExpertise()),
      minWidth: width! * 0.90,
      height: height! * 0.05,
      color: Colors.black,
      child:  const Text(
        'View Expertise ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _addBtn(){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: ()=> add(),
      minWidth: width! * 0.90,
      height: height! * 0.05,
      color: Colors.black,
      child:  const Text(
        'Add ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }


  void add(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      var c = Case();
      c.total = totalCases!;
      c.won = casesWon!;
      c.type = type!;
      Db().addCase(c);
    }

  }

}
