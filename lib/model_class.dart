import 'package:fire_notee/app_constants.dart';

class ModelClass{
  String title;
  String desc;

  ModelClass({required this.title, required this.desc});

  factory ModelClass.fromMap(Map<String,dynamic> map){

    return ModelClass(
        title: map[AppConstants.COL_TITLE],
        desc: map[AppConstants.COL_DESC]);

  }

  Map<String,dynamic> toMap() => {
    AppConstants.COL_TITLE:title,
    AppConstants.COL_DESC:desc
  };

}