import 'dart:io';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lawyer/other/Helper.dart';
import 'package:lawyer/widgets/my_widgets.dart';
import '../Db/db.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? fName,lName,email,password,gender,type,phone;
  var types = ['Client','Lawyer'];
  double? height,width;
  File? image;
  ImageSource? source;


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home:Scaffold(
        appBar:myAppBar(title: 'SignUp',were:'login' ),
        body:myContainer(width: width! * 0.05, widget: _buildUI()),
      ) ,
    );
  }

  Widget _buildUI(){
    return SizedBox(
      height: height! * 0.8,
      child: Form(
        key: _formKey,
        child:Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                    profileImage(),
                    _fNameTxt(),
                    _lNameTxt(),
                   _passwordText(),
                   _emailText(),
                   _contactTxt(),
                    _typeDdl(),
                   _gender(),
                   _registerBtn(),
          ],
        ) ,
      ),
    );
  }

  Widget _fNameTxt(){
    return TextFormField(
      decoration:  InputDecoration(
        hintText:'FirstName..',
        contentPadding:  const EdgeInsets.all(15),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onSaved: (v){
        setState(() {
          fName = v;
        });
      },
      validator:(v)=>v!.isNotEmpty?null:'please enter a first name!',
    );
  }

  Widget _lNameTxt(){
    return TextFormField(
      decoration:  InputDecoration(
        hintText:'LastName..',
        contentPadding:  const EdgeInsets.all(15),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onSaved: (v){
        setState(() {
          lName = v;
        });
      },
      validator:(v)=>v!.isNotEmpty?null:'please enter a last name!',
    );
  }



  Widget _passwordText(){

    return TextFormField(
      obscureText: true,
      decoration:  InputDecoration(
        hintText:'Password...',
        contentPadding:  const EdgeInsets.all(15),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onSaved: (v){
        setState(() {
          password = v;
        });
      },
      validator:(v)=>v!.isNotEmpty?null:'please enter a password !',
    );
  }

  Widget _contactTxt(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration:  InputDecoration(
        hintText:'Contact...',
        contentPadding:  const EdgeInsets.all(15),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onSaved: (v){
        setState(() {
          phone = v!;
        });
      },
      validator:(v)=>v!.isNotEmpty || v.length < 5 && v.length > 14?null:'please enter a contact!',
    );
  }


  Widget _emailText(){
    return TextFormField(
      decoration:  InputDecoration(
        hintText:'Email...',
        contentPadding:  const EdgeInsets.all(15),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onSaved: (v){
        setState(() {
          email = v;
        });
      },
      validator:(v){
        bool valid = EmailValidator.validate(v!.trim());
        return valid?null:'please enter a valid email!';
      },
    );
  }

  Widget _registerBtn(){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: ()=>_save(),
      minWidth: width! * 0.90,
      height: height! * 0.05,
      color: Colors.black,
      child:  const Text(
        'SignUp User ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }


  Widget _typeDdl(){

    var items = types.map((e){
      return DropdownMenuItem(value: e,child: Text(e),);
    }).toList();

    return DropdownButtonFormField(
      hint: const Text('UserType...'),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      value: type,
      validator:(v)=>v == null?'please select type':null ,
      onChanged: (String ? v)=>setState(() { type = v!;}),
      items: items,
    );
  }

  Widget _gender(){
   return Row(
     mainAxisSize: MainAxisSize.max,
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
      const Text('Male'),
      Expanded(
        child: RadioListTile(value: 'Male', groupValue:gender ,
            onChanged: (String? value)=>setState(() { gender = value!;})),
      ),
      const Text('Female'),
      Expanded(
        child: RadioListTile(value: 'Female', groupValue:gender ,
            onChanged: (String? value)=>setState(() { gender = value!;})),
      ),
    ],);
  }



  //image handling

  Widget profileImage(){
    Widget container =image != null?Container(
      height: height! * 0.15,
      width: height! * 0.15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(image!),
        ),
      ),
    ):Container(
      height: height! * 0.15,
      width: height! * 0.15,
      decoration: const BoxDecoration(
      ),
      child:const Icon(Icons.camera_alt,),
    );

    return  GestureDetector(
        onTap: (){
          showImageDialog();
        },
        child: container
    );
  }

  Future _profileImage({required String from})async {
    try{
      if(from == 'g'){
        source = ImageSource.gallery;
      }
      else{
        source = ImageSource.camera;
      }
      final image = await ImagePicker().pickImage(source:source!);
      if(image == null) return;
      final path = File(image.path);
      setState(() { this.image = path;});

    }on PlatformException catch(e){
      Fluttertoast.showToast(msg:e.toString(), toastLength: Toast.LENGTH_LONG,textColor: Colors.red);
    }
  }


  Future<void> showImageDialog() async {

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextButton(onPressed: (){
                  _profileImage(from: 'c');
                  Navigator.pop(context);
                }, child: const Text('Camera')),
                TextButton(onPressed: (){
                  _profileImage(from: 'g');
                  Navigator.pop(context);
                }, child: const Text('Gallery')),
              ],
            ),
          ),
        );
      },
    );
  }



  void _save(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      var user = User(fname: fName,lname: lName,password: password,gender: gender,email: email,type: type,
          picture: image,contact: phone);
      Db().signup(user:user);
    }

  }

}
