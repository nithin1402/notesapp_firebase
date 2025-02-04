import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notee/app_constants.dart';
import 'package:fire_notee/home_page.dart';
import 'package:fire_notee/on_boarding/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();

    var credential;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color:Color(0xff023333),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome",style: TextStyle(fontSize: 30,color:Colors.white,fontWeight: FontWeight.bold),),
                    Text("Back!",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold)),
                    SizedBox(height: 11,),
                    Text("Continue your adventure.",style: TextStyle(color:Colors.white,fontSize: 16),)
                  ],
                ),
              ),
            ),
            Container(
              height: 500,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
        
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
        
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                    SizedBox(height: 21,),
                    TextField(
                      controller: passController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility,color:Color(0xff023333) ,),
                          hintText: "Password",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                    SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () async{
        
                          String email = emailController.text;
                          String pass = passController.text;
        
                          FirebaseAuth auth=FirebaseAuth.instance;

                          try {
                             credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: email,
                                password: pass,
                            );

                             if(credential.user!=null){

                               SharedPreferences prefs = await SharedPreferences.getInstance();
                               prefs.setString("UID", credential.user!.uid);

                             }

                             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No user found for that email.")));
                            } else if (e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong password provided for that user.")));
                            }
                          }
        
                        },
                        child: Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:Color(0xff023333),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text("Log In",style: TextStyle(color: Colors.white,fontSize: 18),),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 21,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an Account? "),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                          },
                            child: Text(" Sign Up",style: TextStyle(color:Color(0xff023333),fontSize: 16,fontWeight: FontWeight.bold),))
                      ],
                    ),
                  ],
                ),
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}
