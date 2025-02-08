import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notee/model_class.dart';

abstract class NoteEvent{}

class AddNoteEvent extends NoteEvent{
  ModelClass modelClass;
  AddNoteEvent({required this.modelClass});
}

class FetchInitialNotesEvent extends NoteEvent{
  // ModelClass modelClass;
  // FetchInitialNotesEvent({required this.modelClass});
}

class UpdateNoteEvent extends NoteEvent{
  ModelClass modelClass;
  UpdateNoteEvent({required this.modelClass});
}

class DeleteNoteEvent extends NoteEvent{

  var id;
  DeleteNoteEvent({required this.id});

}