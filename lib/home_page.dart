
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notee/add_note_page.dart';
import 'package:fire_notee/app_constants.dart';
import 'package:fire_notee/model_class.dart';
import 'package:fire_notee/on_boarding/login_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  // var checkLogin;
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getvalueFromPrefs();
  // }
  //
  //
  //
  // void getvalueFromPrefs() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   checkLogin = prefs.getStringList("authenticate") ?? "";
  //
  //   Widget navigateTo = LoginPage();
  //
  //   if (checkLogin != "") {
  //     navigateTo = HomePage();
  //   }
  //
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => navigateTo));
  // }

  FirebaseFirestore ff= FirebaseFirestore.instance;

  DateFormat df = DateFormat.Hms();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: ff.collection(AppConstants.TAB_NOTE).orderBy("created_at",descending: true).snapshots(),
        builder: (_,snap) {
          if(snap.hasData){
            return ListView.builder(
              itemCount: snap.data!.docs.length,
                itemBuilder: (_,index){

              return ListTile(
                title: Text(snap.data!.docs[index].data()["title"]),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snap.data!.docs[index].data()["desc"]),
                    Text(df.format(DateTime.fromMillisecondsSinceEpoch(snap.data!.docs[index].data()["created_at"])))
                  ],
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateNotePage(mData:snap.data!.docs[index].id)));

                      }, icon: Icon(Icons.edit)),
                      IconButton(onPressed: () {
                        ff.collection(AppConstants.TAB_NOTE).doc(snap.data!.docs[index].id).delete();
                      }, icon: Icon(Icons.delete,color: Colors.red,)),
                    ],
                  ),
                )
              );
            });
          }
          return Container();

        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotePage()));
      }, child: Icon(Icons.add),),
    );
  }
}
