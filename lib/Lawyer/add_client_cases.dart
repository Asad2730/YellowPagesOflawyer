import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lawyer/Db/db.dart';
import 'package:lawyer/other/Helper.dart';

import '../widgets/my_widgets.dart';

class AddClientCase extends StatefulWidget {
  final String clientEmail,type;
  const AddClientCase({required this.clientEmail,required this.type,Key? key}) : super(key: key);

  @override
  State<AddClientCase> createState() => _AddClientCaseState();
}

class _AddClientCaseState extends State<AddClientCase> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? city,court;
  var selectedDate = '';
  double? height,width;
  DateTime date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        String format = '${date.day}/${date.month}/${date.year}';
        selectedDate = format;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home:Scaffold(
        appBar:myAppBar(title: 'Add Case',were:'back' ),
        body:myContainer(width: width! * 0.05, widget: _buildUI()),
      ) ,
    );
  }


  Widget _title(){
    return  Text(
       widget.type,
      style:const TextStyle(
        fontSize: 30,
        color:Colors.black,
        fontWeight: FontWeight.w900,
      ),
    );
  }


  Widget _buildUI(){
    return SizedBox(
      height: height! * 0.6,
      child: Form(
        key: _formKey,
        child:Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               _title(),
               _cities(),
               _courts(),
               _date(),
               _save(),
          ],
        ) ,
      ),
    );
  }


  Widget _cities(){

    var items = Method.cities.map((e){
      return DropdownMenuItem(value: e,child: Text(e),);
    }).toList();

    return DropdownButtonFormField(
      hint: const Text('Select City...'),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator:(v)=>v == null?'please select a city':null ,
      onChanged: (String ? v)=>setState(() { city = v!;}),
      items: items,
    );
  }


  Widget _courts(){

    var items = Method.courts.map((e){
      return DropdownMenuItem(value: e,child: Text(e),);
    }).toList();

    return DropdownButtonFormField(
      hint: const Text('Select Court...'),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator:(v)=>v == null?'please select a court':null ,
      onChanged: (String ? v)=>setState(() { court = v!;}),
      items: items,
    );
  }

  Widget _date(){
     return GestureDetector(
       child: Row(
         mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           const SizedBox(width: 20,),
           Expanded(child: Text(selectedDate,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
           const SizedBox(width: 20,),
           const Expanded(child: Icon(Icons.calendar_today)),
         ],
       ),
       onTap:()=>_selectDate(context) ,
     );
  }

  Widget _save(){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: ()=>saveData(),
      minWidth: width! * 0.90,
      height: height! * 0.05,
      color: Colors.black,
      child:  const Text(
        'Save',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }


  void saveData(){
     bool valid = true;
     //condition is incorrect
     if(court == 'Supreme Court' && city != 'Islamabad' ){
       valid = false;
     }
     if(_formKey.currentState!.validate() && valid){
      _formKey.currentState!.save();
       String lawyerEmail = Method.loggedUser.elementAt(0).email;
       Db().addClientsCase(clientEmail: widget.clientEmail, lawyerEmail: lawyerEmail,
           type: widget.type, court: court!, city: city!, date: selectedDate);
    }else
     {
       Fluttertoast.showToast(msg:'Incorrect city for supreme court!',textColor: Colors.red);
     }
  }


}
