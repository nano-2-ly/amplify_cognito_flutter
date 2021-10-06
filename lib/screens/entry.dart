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
    Get.toNamed("/dashboard");
  }
}