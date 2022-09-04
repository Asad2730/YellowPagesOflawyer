import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lawyer/Db/db.dart';
import 'package:lawyer/widgets/my_widgets.dart';


class RateLawyer extends StatefulWidget {
  const RateLawyer({Key? key}) : super(key: key);

  @override
  State<RateLawyer> createState() => _RateLawyerState();
}

class _RateLawyerState extends State<RateLawyer> {

  late Future _future;
  late List<double> ratings;
  double? height,width;

  @override
  Widget build(BuildContext context) {
    _future = Db().rateLawyersList();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        appBar: myAppBar(title: 'RateLawyer', were: 'back'),
        body: SafeArea(child: _futureBuilder()),
        drawer: myClientDrawer(),
      ),
    );
  }

  Widget _futureBuilder(){

    return FutureBuilder(
        future:_future ,
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return _list(snapshot);

          }else{
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }


  Widget _list(AsyncSnapshot snapshot){
    ratings = List.filled(snapshot.data.length, 1);
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:snapshot.data.length,
        itemBuilder: (context,i){
          Map data = snapshot.data[i];
          String url = snapshot.data[i]['picture'];
          return Card(
            child: ListTile(
              leading: myImages(url: url),
              title:Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height:10 ,),
                  Text('Name : ${data['name']}'),
                  const SizedBox(height:10 ,),
                  Text('Email : ${data['email']}'),
                  const SizedBox(height:10 ,),
                  Text('Case : ${data['type']}'),
                  const SizedBox(height:10 ,),
                  Text('Date : ${data['date']}'),
                  const SizedBox(height:10 ,),
                  _rate(i),
                  const SizedBox(height:10 ,),
                  _finishBtn(i,data),
                  const SizedBox(height:20 ,),
                ],
              ),
            ),
          );
        }) ;
  }


  Widget _rate(int i){
    return RatingBar.builder(
      initialRating: 1,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
        ratings[i] = rating;
      },
    );
  }


  Widget _finishBtn(int i,Map data){

    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: ()=> Db().updateRating(email: data['email'], rate:ratings[i], type: data['type']),
      minWidth: width! * 0.30,
      height: height! * 0.05,
      color: Colors.black,
      child:  const Text(
        'Rate lawyer',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

}
