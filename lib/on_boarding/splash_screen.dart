import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var checkLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3),() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      checkLogin = prefs.getStringList("authenticate") ?? "";

      Widget navigateTo = LoginPage();

      if (checkLogin != "") {
        navigateTo = HomePage();
      }

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => navigateTo));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Welcome"),
      )
    );
  }
}
