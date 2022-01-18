import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/login.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    hasAvailableSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: OAuthFAB(),
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Login(),
      ),
    );
  }
}

void hasAvailableSession() async{
  var session = await Amplify.Auth.fetchAuthSession();

  if(session.isSignedIn){
    Get.offAndToNamed("/dashboard");
  }
}

Widget OAuthFAB(){
  return Stack(
    children: [
      Positioned(
        bottom: 10,
        right: 0,
        child: FloatingActionButton(
          onPressed: () async{
            try {
              //print("Amplify.Auth.getCurrentUser()");
              //print(await Amplify.Auth.getCurrentUser());
              //Amplify.Auth.signOut();
              SignInResult res = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
              print("res.isSignedIn");
              if(res.isSignedIn){
                Get.offAndToNamed("/dashboard");
              }
            } on AuthException catch (e) {
              print("e.message");
              print(e.message);
            }

          },
          child: Center(child: Text("G", style: TextStyle(color: Colors.black),),),
          backgroundColor: Colors.white,
        ),
      ),
      Positioned(
        bottom: 10,
        right: 80,
        child: FloatingActionButton(
          onPressed: () async{
            try {
              //print("Amplify.Auth.getCurrentUser()");
              //print(await Amplify.Auth.getCurrentUser());
              //Amplify.Auth.signOut();
              SignInResult res = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.facebook);
              print("res.isSignedIn");
              if(res.isSignedIn){
                Get.offAndToNamed ("/dashboard");
              }
            } on AuthException catch (e) {
              print("e.message");
              print(e.message);
            }

          },
          child: Center(child: Text("f", style: TextStyle(color: Colors.blueAccent),),),
          backgroundColor: Colors.white,
        ),
      ),
    ],
  );
}