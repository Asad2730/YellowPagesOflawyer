import 'package:flutter/material.dart';
import 'package:lawyer/Db/db.dart';
import 'package:lawyer/other/Helper.dart';
import 'package:lawyer/widgets/my_widgets.dart';



class SavePersonal extends StatefulWidget {
  const SavePersonal({Key? key}) : super(key: key);

  @override
  State<SavePersonal> createState() => _SavePersonalState();
}

class _SavePersonalState extends State<SavePersonal> {

  double? height,width;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? address,officeNo,education,city;
  var cities = ['Rawalpindi','Lahore','Karachi','Faisalabad','Peshawar'];


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar:myAppBar(title: 'Personal', were: 'personal'),
        body:myContainer(width: width! * 0.05, widget: _buildUI()),
        drawer:myDrawer(),
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
              _address(),
             _officeNoTxt(),
            _education(),
            _cities(),
            _addBtn(),
          ],
        ) ,
      ),
    );
  }





  Widget _education(){
    return TextFormField(
      decoration:  InputDecoration(
        hintText:'Education',
        contentPadding:  const EdgeInsets.all(15),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onSaved: (v){
        setState(() {
          education = v!;
        });
      },
      validator:(v)=>v!.isNotEmpty?null:'please enter a education!',
    );
  }


  Widget _address(){
    return TextFormField(
      decoration:  InputDecoration(
        hintText:'Address',
        contentPadding:  const EdgeInsets.all(15),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onSaved: (v){
        setState(() {
          address = v!;
        });
      },
      validator:(v)=>v!.isNotEmpty?null:'please enter a address!',
    );
  }


  Widget _officeNoTxt(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration:  InputDecoration(
        hintText:'OfficeNO...',
        contentPadding:  const EdgeInsets.all(15),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onSaved: (v){
        setState(() {
          officeNo = v!;
        });
      },
      validator:(v)=>v!.isNotEmpty || v.length < 5 && v.length > 14?null:'please enter  office no!',
    );
  }


  Widget _addBtn(){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: ()=>_save(),
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

  Widget _cities(){

    var items = cities.map((e){
      return DropdownMenuItem(value: e,child: Text(e),);
    }).toList();

    return DropdownButtonFormField(
      hint: const Text('City...'),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          )
      ),
      value: city,
      validator:(v)=>v == null?'please select city':null,
      onChanged: (String ? v)=>setState(() { city = v!;}),
      items: items,
    );

  }


  void _save(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      var p = Personal();
      p.address = address!;
      p.officeNo = officeNo!;
      p.education = education!;
      p.city = city!;
      Db().addPersonal(p);
    }

  }

}
