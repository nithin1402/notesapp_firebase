import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
               ElevatedButton(onPressed: () {
                 ff.collection(AppConstants.TAB_NOTE).add({
                   AppConstants.COL_TITLE : titleController.text,
                   AppConstants.COL_DESC : descController.text,
                   AppConstants.COL_CREATED_AT : DateTime.now().millisecondsSinceEpoch
                 });
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
