import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lawyer/widgets/my_widgets.dart';
import '../other/Helper.dart';


//not used any were may be
class AddCase extends StatefulWidget {
  final String userEmail,caseType;
  const AddCase(this.userEmail, this.caseType, {Key? key}) : super(key: key);
  @override
  State<AddCase> createState() => _AddCaseState();
}

class _AddCaseState extends State<AddCase> {
  String? city,court;
  var date ='';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double? height,width;
  var selectedDate =  DateTime.now();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: myAppBar(title: 'Clients', were: 'cases'),
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
            _cities(),
            _courts(),
            _selectDateBtn(),
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


  Widget _selectDateBtn(){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: ()=>_selectDate(context),
      minWidth: width! * 0.20,
      height: height! * 0.05,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(date,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
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


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:selectedDate,
        firstDate:DateTime.now(),
        lastDate: DateTime(2050));
    if (picked != null ) {
      setState(() {
        selectedDate = picked;
        var time = '${picked.day}/${picked.month}/${picked.year}';
        date = time;
      });
    }
  }

  void save(){
    var valid = true;
    if(court == 'Supreme Court' && city != 'Islamabad'){
      valid = false;
    }
    print(valid);

    if(valid){
      print(date);
      print(court);
      print(city);
      print(Method.loggedUser.elementAt(0).email);
      print(widget.userEmail);
      print(widget.caseType);
    }else{
      Fluttertoast.showToast(msg: 'Invalid city!');
    }
  }


}
