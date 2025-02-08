import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notee/app_constants.dart';
import 'package:fire_notee/bloc/note_event.dart';
import 'package:fire_notee/bloc/note_state.dart';
import 'package:fire_notee/model_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteBloc extends Bloc<NoteEvent,NoteState>{

  FirebaseFirestore ff= FirebaseFirestore.instance;

  NoteBloc() : super(NoteInitialState()){

    on<AddNoteEvent>((event,emit) async{
      emit(NoteLoadedState());

      try {
        ff.collection(AppConstants.TAB_NOTE).add(event.modelClass.toMap());
        add(FetchInitialNotesEvent());
      }catch(e){
        emit(NoteErrorState(errorMsg: "Failed to add note : $e"));
      }


    });

    on<FetchInitialNotesEvent>((event,emit) async{

      emit(NoteLoadedState());

      try{

        QuerySnapshot querySnapshot = await ff.collection(AppConstants.TAB_NOTE).get();

      }catch(e){
        emit(NoteErrorState(errorMsg: "Failed to get notes : $e"));
      }


    });

    on<FetchInitialNotesEvent>((event,emit) async{
      
    });

  }

}