import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:lawyer/Db/db.dart';
import 'package:lawyer/other/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double? height,width;
  String? email,password;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: width! * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _title(),
                _loginForm(),
                _loginBtn(),
                _signup(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _title(){
    return const Text(
      'Login',
      style:TextStyle(
        fontSize: 30,
        color:Colors.black,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _loginForm(){
    return SizedBox(
      height: height! * 0.20,
      child: Form(
        key: _formKey,
        child:Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _emailText(),
            _passwordText(),
          ],
        ) ,
      ),
    );
  }


  Widget _loginBtn(){

    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: ()=> _login(),
      minWidth: width! * 0.90,
      height: height! * 0.06,
      color: Colors.black,
      child: const Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
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

  Widget _signup(){
    return GestureDetector(
      onTap: ()=>Get.to(()=> const SignUp()),
      child: const Text(
        "Don't have an account?Signup",
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }



  void _login(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      Db().login(email!, password!);
    }
  }



}
