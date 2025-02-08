import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notee/bloc/note_bloc.dart';
import 'package:fire_notee/bloc/note_event.dart';
import 'package:fire_notee/model_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_constants.dart';

class AddNotePage extends StatelessWidget {

  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();

  FirebaseFirestore ff= FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
         children: [
           TextField(
             controller: titleController,
             decoration: InputDecoration(
               hintText: "Enter title here",
               labelText: "Title",
               focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20)
               ),
               enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20)
               )
             ),
           ),
           SizedBox(height: 21,),
           TextField(
             controller: descController,
             decoration: InputDecoration(
                 hintText: "Enter description here",
                 labelText: "Description",
                 focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(20)
                 ),
                 enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(20)
                 )
             ),
           ),
           SizedBox(height: 21,),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               ElevatedButton(onPressed: () {
                 Navigator.pop(context);
               }, child: Text("Calcel")),
               SizedBox(width: 11,),
               ElevatedButton(onPressed: () async{

                 SharedPreferences prefs = await SharedPreferences.getInstance();
                 String uid = prefs.getString("UID") ?? "";

                 context.read<NoteBloc>().add(AddNoteEvent(modelClass: ModelClass(title: titleController.text, desc: descController.text)));

                 // ff.collection(AppConstants.TAB_NOTE).add({
                 //   AppConstants.COL_TITLE : titleController.text,
                 //   AppConstants.COL_DESC : descController.text,
                 //   AppConstants.COL_CREATED_AT : DateTime.now().millisecondsSinceEpoch,
                 //   "uid" : uid
                 // });

                 Navigator.pop(context);
               }, child: Text("Add"))
             ],
           )
         ],
        ),
      ),
    );
  }
}


class UpdateNotePage extends StatelessWidget {

  var mData;
  UpdateNotePage({required this.mData});

  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();

  FirebaseFirestore ff= FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Notes"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Enter title here",
                  labelText: "Title",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
            ),
            SizedBox(height: 21,),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                  hintText: "Enter description here",
                  labelText: "Description",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
            ),
            SizedBox(height: 21,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text("Calcel")),
                SizedBox(width: 11,),
                ElevatedButton(onPressed: () {
                  ff.collection(AppConstants.TAB_NOTE).doc(mData).update(
                      {
                        AppConstants.COL_TITLE : titleController.text,
                        AppConstants.COL_DESC : descController.text
                      });
                  Navigator.pop(context);
                }, child: Text("Update"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
