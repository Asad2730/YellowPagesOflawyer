import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer/Client/home.dart';
import 'package:lawyer/Client/notification.dart';
import 'package:lawyer/Client/rateLawyer.dart';
import 'package:lawyer/myNav.dart';
import 'package:lawyer/other/Helper.dart';
import 'package:lawyer/other/login.dart';
import '../Db/db.dart';


AppBar myAppBar({required String? title,required String were}){
  return AppBar(
     title: Text(title!),
      actions: [
        ElevatedButton.icon(
          style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black)),
          onPressed:(){
            myNav(were);
          },
          icon: const Icon(Icons.arrow_back),
          label:const Text('') ,
        ),
      ],
      backgroundColor: Colors.black,
  );

}

AppBar taskAppBar(){
  return AppBar(
   // title: Text(title!),
    actions: [
      ElevatedButton.icon(
        style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black)),
        onPressed:(){
          Db().closeAll();
        },
        icon: const Icon(Icons.pending),
        label:const Text('Close All Open Cases') ,
      ),

      ElevatedButton.icon(
        style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black)),
        onPressed:(){
          myNav('task');
        },
        icon: const Icon(Icons.all_inbox_rounded),
        label:const Text('Show All') ,
      ),

    ],
    backgroundColor: Colors.black,
  );

}

Widget myImages({required String url}){
  return url != ''?CircleAvatar(backgroundImage:NetworkImage(ip+url)):const Icon(Icons.person);
}


Widget myContainer({required double width,required Widget widget}){
  return SafeArea(
    child:Container(
      padding: EdgeInsets.symmetric(horizontal: width),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget,
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget myDrawer(){
    return Drawer(
      child:ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black,),
              child:Column(
                children: [
                  CircleAvatar(backgroundColor: Colors.green,
                    radius: 40,child:
                   Text(Method.loggedUser.elementAt(0).email[0].toString().toUpperCase(),
                    style: const TextStyle(fontSize: 50),
                  ),
                  ),
                  const SizedBox(height: 10,),
                  Text(Method.loggedUser.elementAt(0).fname+" "+Method.loggedUser.elementAt(0).lname,
                    style:const TextStyle(fontSize: 16,color: Colors.white) ,),
                  const SizedBox(height: 5,),
                  Text(Method.loggedUser.elementAt(0).email,
                    style:const TextStyle(fontStyle: FontStyle.normal,color: Colors.blue) ,),
                ],
              )
          ),
          ListTile(
            trailing: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: ()=>Get.to(()=> const Login()),
          ),
        ],
      ),
    );
  }



Widget myClientDrawer(){
  return Drawer(
    child:ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black,),
            child:Column(
              children: [
                CircleAvatar(backgroundColor: Colors.green,
                  radius: 40,child:
                  Text(Method.loggedUser.elementAt(0).email[0].toString().toUpperCase(),
                    style: const TextStyle(fontSize: 50),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(Method.loggedUser.elementAt(0).fname+" "+Method.loggedUser.elementAt(0).lname,
                  style:const TextStyle(fontSize: 16,color: Colors.white) ,),
                const SizedBox(height: 5,),
                Text(Method.loggedUser.elementAt(0).email,
                  style:const TextStyle(fontStyle: FontStyle.normal,color: Colors.blue) ,),
              ],
            )
        ),
        ListTile(
          trailing: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: ()=>Get.to(()=> const ClientHome()),
        ),
        ListTile(
          trailing: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          onTap: ()=>Get.to(()=> const ClientNotifications()),
        ),
        ListTile(
          trailing: const Icon(Icons.star_rate),
          title: const Text('Rate Lawyer'),
          onTap: ()=>Get.to(()=> const RateLawyer()),
        ),
        ListTile(
          trailing: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: ()=>Get.to(()=> const Login()),
        ),
      ],
    ),
  );
}


