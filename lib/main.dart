import 'dart:async';

import 'package:fire_notee/bloc/note_bloc.dart';
import 'package:fire_notee/fire_base/mobile_login_page.dart';
import 'package:fire_notee/firebase_options.dart';
import 'package:fire_notee/home_page.dart';
import 'package:fire_notee/model_class.dart';
import 'package:fire_notee/on_boarding/login_page.dart';
import 'package:fire_notee/on_boarding/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MobileLoginPage()
      //BlocProvider(create: (context)=>NoteBloc(),child: SplashScreen(),)

    );
  }
}

