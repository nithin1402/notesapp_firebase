import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model_class.dart';

abstract class NoteState{}

class NoteInitialState extends NoteState{

  NoteInitialState();

}

class NoteLoadingState extends NoteState{}

class NoteLoadedState extends NoteState{

  //List<ModelClass> mNotes;
  //NoteLoadedState({required this.mNotes});

}

class NoteErrorState extends NoteState{
  String errorMsg;
  NoteErrorState({required this.errorMsg});
}