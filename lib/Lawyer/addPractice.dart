import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lawyer/Db/db.dart';

import '../other/Helper.dart';


class AddPractice extends StatefulWidget {
  const AddPractice({Key? key}) : super(key: key);

  @override
  State<AddPractice> createState() => _AddPracticeState();
}

class _AddPracticeState extends State<AddPractice> {

  String? city,court;
  var to ='',from='';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var toDate =  DateTime.now();
  var fromDate =  DateTime.now();
  double? height,width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return _buildUI();
  }


  Widget _buildUI(){
    return SizedBox(
      height: height! * 0.60,
      child: Form(
        key: _formKey,
        child:Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             const SizedBox(height: 20,),
            _cities(),
            _courts(),
            _toDateBtn(),
            _fromDateBtn(),
            _add(),
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
      hint: const Text('City...'),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          )
      ),
      value: city,
      validator:(v)=>v == null?'please select city':null ,
      onChanged: (String ? v)=>setState(() { city = v!;}),
      items: items,
    );
  }

  Widget _courts(){

    var items = Method.courts.map((e){
      return DropdownMenuItem(value: e,child: Text(e),);
    }).toList();

    return DropdownButtonFormField(
      hint: const Text('Court...'),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          )
      ),
      value: court,
      validator:(v)=>v == null?'please select court':null ,
      onChanged: (String ? v)=>setState(() { court = v!;}),
      items: items,
    );
  }


  Widget _toDateBtn(){
    return MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: ()=>_selectToDate(context),
        minWidth: width! * 0.20,
        height: height! * 0.05,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(to,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            const Icon(Icons.calendar_today,size: 24,)
          ],
        )
    );
  }

  Widget _fromDateBtn(){
    return MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: ()=>_selectFromDate(context),
        minWidth: width! * 0.20,
        height: height! * 0.05,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(from,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            const Icon(Icons.calendar_today,size: 24,)
          ],
        )
    );
  }


  Widget _add(){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: ()=>save(),
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


  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:toDate,
        firstDate:DateTime.now(),
        lastDate: DateTime(2050));
    if (picked != null ) {
      setState(() {
        toDate = picked;
        var time = '${picked.day}/${picked.month}/${picked.year}';
        to = time;
      });
    }
  }



  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:toDate,
        firstDate:DateTime.now(),
        lastDate: DateTime(2050));
    if (picked != null ) {
      setState(() {
        fromDate = picked;
        var time = '${picked.day}/${picked.month}/${picked.year}';
        from = time;
      });
    }
  }

  void save(){
    var valid = true;
    if(court == 'Supreme Court' && city != 'Islamabad'){
      valid = false;
    }
    if(valid){
      Db().addPractice(to: to, from: from, city: city!, court: court!);
    }else{
      Fluttertoast.showToast(msg: 'Invalid city!');
    }
  }




}
