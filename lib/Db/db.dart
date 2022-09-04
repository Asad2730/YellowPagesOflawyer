import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lawyer/myNav.dart';
import '../other/Helper.dart';
//do not import get package for form data


const ip = 'http://192.168.10.11/FypApi';

class Db{

  final Dio dio = Dio();
  Db(){
   dio.options.baseUrl = '$ip/api/My/';
  }

  Future setUpPersonal(var email) async{
   var  response = await dio.get('getAdditionalInfo',queryParameters: {
     'email':email,
   });
    if(response.toString() != 'null'){
     Method.personalInfo.clear();
     var p = Personal();
     p.education = response.data['education'];
     p.city = response.data['city'];
     p.officeNo = response.data['officeNo'];
     p.address = response.data['address'];
     Method.personalInfo.add(p);
    }
    myNav('lawyerHome');
  }


  Future signup({required User user}) async {
    try{
      var formData = FormData.fromMap(
           {'img': await MultipartFile.fromFile(user.picture.path.toString())});

      var response = await dio.post('signup',queryParameters: {
         'fName':user.fname,
         'lName':user.lname,
         'gender':user.gender,
         'email':user.email.toLowerCase().trim(),
         'password':user.password.trim(),
         'type':user.type,
         'contact':user.contact,
       },data:formData );

      Fluttertoast.showToast(msg: response.toString());
      myNav('login');
    }catch(e){
      print('Ex:${e.toString()}');
    }
  }


  Future login(String email,String password) async{
    try{
      print(dio.options.baseUrl);
      var response = await dio.post('login',data: {'email':email.trim(),
        'password':password.trim(),});
       print(response);
        if(response.toString() == "1") {
          Fluttertoast.showToast(msg: 'Account temporary blocked!',
            textColor:Colors.red, backgroundColor:Colors.transparent,
            fontSize: 20.0,toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM,);
        }else{
          Method.loggedUser.clear();
          var u = User();
          u.fname = response.data['fName'];
          u.lname = response.data['lName'];
          u.email = response.data['email'];
          u.contact = response.data['contact'];
          u.password = response.data['password'];
          u.gender = response.data['password'];
          u.type = response.data['type'];
          u.picture = response.data['picture'];
          Method.loggedUser.add(u);
          Fluttertoast.showToast(msg: 'Login Successfully');
          loggingUser(u.type, email);
        }

    }catch(e){
      print('Ex:${e.toString()}');
      Fluttertoast.showToast(msg: 'Invalid credentials');
    }

  }

  Future loggingUser(var type,var email)async{
    if(type == 'Lawyer'){
      setUpPersonal(email);
    }else if(type == 'Client'){
       myNav('clientHome');
    }else{
      myNav('admin');
    }
  }


  Future loadAdmin() async{
    var response = await dio.get('loadAdminUsers');
    return response.data as List;
  }


  Future addPersonal(Personal p) async{
    try{
      var request = await dio.post('addPersonal',data: {
        'email':Method.loggedUser.elementAt(0).email,
        'address':p.address,
        'education':p.education,
        'city':p.city,
        'officeNo':p.officeNo
      });
      setUpPersonal(Method.loggedUser.elementAt(0).email);
      Fluttertoast.showToast(msg: request.toString());
    }catch(ex){
      print(ex);
    }
  }

  //for expertise
  Future addCase(Case c) async{
    try{
      var request = await dio.post('addCase',data: {
        'email':Method.loggedUser.elementAt(0).email,
        'type':c.type,
        'total':c.total,
        'won':c.won,
      });
      Fluttertoast.showToast(msg: request.toString());
      myNav('lawyerHome');
    }catch(ex){
      print(ex);
    }
  }


  Future viewExpertise() async{
    try{
      var request = await dio.get('viewExpertise',queryParameters: {
        'email':Method.loggedUser.elementAt(0).email,
      });
      return request.data as List;
    }catch(ex){
      print(ex);
    }
  }


  Future searchLawyer({required String type}) async{
    try{
      var response = await dio.get('searchLawyer?',queryParameters: {
        'type':type,
      });
      return response.data as List;
    }catch(e){
      print(e);
    }
  }


  Future changeRequestStatus({required String clientEmail,required String lawyerEmail
    ,required String status,required String type}) async{
    try{
      var request = await dio.post('changeRequestStatus',queryParameters: {
        'layerEmail':lawyerEmail,
         'clientEmail':clientEmail,
        'status':status,
         'type':type,
      });
      Fluttertoast.showToast(msg: request.toString());

    }catch(e){print(e);}
  }

  Future sendRequest({required String clientEmail,required  String lawyerEmail,
    required String status,required String type}) async{
    try{
      var now = DateTime.now();
      String date = '${now.year}-${now.month}-${now.day}';
      var request = await dio.post('sendRequest',data: {
        'status':status,
        'clientEmail':clientEmail.toString().trim(),
        'lawyerEmail':lawyerEmail.toString().trim(),
        'date':date,
        'type': type,
      });
      Fluttertoast.showToast(msg: request.toString());

    }catch(e){print(e);}
  }

  Future changeUserStatus({required String email}) async{
    try{
      var request = await dio.post('changeUserStatus',queryParameters: {
        'email':email,
      });
      Fluttertoast.showToast(msg: request.toString());
    }catch(e){print(e);}
  }


  Future loadRequests({required String status}) async{
    try{
       var response = await dio.get('viewRequest',queryParameters: {
        'email':Method.loggedUser.elementAt(0).email,
        'status':status
      });
      return response.data as List;

    }catch(e){print(e);}

  }


  Future addClientsCase({required String clientEmail,required String lawyerEmail,
    required String type,required String court,required String city,required String date}) async{
     try{
       var response = await dio.post('addClientCase',data: {
         'clientEmail':clientEmail, 'lawyerEmail':lawyerEmail,
         'type':type,'court':court,
         'city':city,'date':date,
       });
       Fluttertoast.showToast(msg: response.toString());
       myNav('back');
     }catch(e){print(e);}
  }


  Future getLawyerClients() async{
    try{
      var response = await dio.get('getClientCase',queryParameters: {
        'email':Method.loggedUser.elementAt(0).email,
      });
      return response.data as List;
    }catch(e){print(e);}
  }



  Future addPractice({required String to,required String from,required String city,required String court}) async{
    try{
      var response = await dio.post('addPractice',queryParameters: {
        'to':to,'from':from,'city':city,'court':court,'email':Method.loggedUser.elementAt(0).email
      });
      Fluttertoast.showToast(msg: response.toString());
      myNav('lawyerHome');
    }catch(e){print(e);}

  }


  Future getPractice() async{
    try{
      var response = await dio.get('getPractice',queryParameters: {
        'email':Method.loggedUser.elementAt(0).email
      });
      return response.data as List;
    }catch(e){print(e);}

  }

  Future clientNotification() async{
    try{
      var response = await dio.get('clientNotifications',queryParameters: {'email':Method.loggedUser.elementAt(0).email});
      return response.data as List;
    }catch(e){print(e);}

  }

  Future closeCase({required int id,required String result}) async{
    try{
      var response = await dio.post('closeCase',queryParameters: {'id':id,'result':result});
      Fluttertoast.showToast(msg: response.toString());
    }catch(e){print(e);}

  }

  Future rateLawyersList() async{
    try{
      var response = await dio.get('rateLawyersList',queryParameters: {'email':Method.loggedUser.elementAt(0).email});
      return response.data as List;
    }catch(e){print(e);}

  }


  Future updateRating({required String email,required double rate,required String type}) async{

    try{
      var response = await dio.post('updateRating',queryParameters: {
        'type':type,
        'clientEmail':Method.loggedUser.elementAt(0).email,
        'lawyerEmail':email,
        'rate':rate,
      });
      Fluttertoast.showToast(msg: response.toString());
    }catch(e){print(e);}
  }


  Future closeAll() async{
    try{
      var request = await dio.post('closeAll',queryParameters: {
        'email':Method.loggedUser.elementAt(0).email,
      });
      Fluttertoast.showToast(msg: request.toString());
     }catch(ex){ print(ex.toString());}

}

Future showAll() async{
    try{
      var request = await dio.get('showAll',queryParameters: {'email':Method.loggedUser.elementAt(0).email});
      print('req: ${request}');
      return request.data as List;

    }catch(e){
      print(e.toString());
    }
}



}



