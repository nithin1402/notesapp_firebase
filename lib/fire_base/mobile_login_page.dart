import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileLoginPage extends StatelessWidget {
  
  TextEditingController mobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: mobController,
            
            
          ),
          SizedBox(height: 11,),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpPage(verificationID: "234")));

            FirebaseAuth mAuth = FirebaseAuth.instance;


            String mobNo = "+91${mobController.text}";

            mAuth.verifyPhoneNumber(
                verificationCompleted: (authCred) {

                },
                verificationFailed: (e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error : ${e.toString()}")));
                },
                codeSent: (verificationId , resendToken){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpPage(verificationID: verificationId)));
            },
                codeAutoRetrievalTimeout: (verificationId){

                }
            );

          }, child: Text("Send OTP"))
        ],
      ),
    );
  }
}

class OtpPage extends StatelessWidget {

  String verificationID;
  OtpPage({required this.verificationID});

  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 70,
                child: TextField(
                  controller: otp1,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                height: 100,
                width: 70,
                child: TextField(
                  controller: otp2,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              SizedBox(width: 30,),
              SizedBox(
                height: 100,
                width: 70,
                child: TextField(
                  controller: otp3,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                height: 100,
                width: 70,
                child: TextField(

                  controller: otp4,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              SizedBox(width: 10,),
            ],
          ),
          SizedBox(height: 11,),
          ElevatedButton(onPressed: () async{

            String otpCode = "";
            FirebaseAuth auth = FirebaseAuth.instance;

            try {
              PhoneAuthCredential mobCred = PhoneAuthProvider.credential(
                  verificationId: verificationID, smsCode: otpCode);
             UserCredential userCred = await auth.signInWithCredential(mobCred);

             userCred.user!.uid;

             //shared Prefs
            }catch(e){

            }

          }, child: Text("Verify OTP"))
        ],
      ),
    );
  }
}

