import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notee/app_constants.dart';
import 'package:fire_notee/on_boarding/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneNoController = TextEditingController();
    TextEditingController passController = TextEditingController();

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
                    Text("Create",style: TextStyle(fontSize: 30,color:Colors.white,fontWeight: FontWeight.bold),),
                    Text("Account.",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold)),
                 ],
                ),
              ),
            ),
            Container(
              height: 600,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "Full Name",
        
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
        
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                    SizedBox(height: 11,),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.visiblePassword,
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
                    SizedBox(height: 11,),
                    TextField(
                      controller: phoneNoController,
                      decoration: InputDecoration(
                          hintText: "Phone Number",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
        
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                    SizedBox(height: 11,),
                    TextField(
                      controller: passController,
                      keyboardType: TextInputType.visiblePassword,
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
                    SizedBox(height: 21,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () async{
                          String name=nameController.text;
                          String email=emailController.text;
                          String phone=passController.text;
                          String pass=passController.text;

                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setStringList("authenticate", [name,pass]);
        
                          FirebaseAuth fireAuth = FirebaseAuth.instance;
                          
                          try{
                            UserCredential userCred = await fireAuth.createUserWithEmailAndPassword(email: email, password: pass);
                            
                            if(userCred.user!=null){
                              FirebaseFirestore ff = FirebaseFirestore.instance;
                              
                              ff.collection(AppConstants.COLL_USERS).doc(userCred.user!.uid).set({
                                    "name" :name,
                                "email" :email,
                                "phone" :phone,
                                "pass" :pass,
                                "created_at" : DateTime.now().millisecondsSinceEpoch
                                  });
                            }
                            Navigator.pop(context);
                          } on FirebaseAuthException catch(e){
                            if (e.code == 'weak-password') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak.")));
                            } else if (e.code == 'email-already-in-use') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email.")));
                            }
                          }
                          catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                          //Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color:Color(0xff023333),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 18),),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 11,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an Account? "),
                        InkWell(
                            onTap: () {
                             Navigator.pop(context);
                            },
                            child: Text(" Log In",style: TextStyle(color:Color(0xff023333),fontSize: 16,fontWeight: FontWeight.bold),))
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
