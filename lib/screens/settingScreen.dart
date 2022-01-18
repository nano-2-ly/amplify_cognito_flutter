
import 'package:amplify_cognito_flutter/font/normal.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class settingScreen extends StatelessWidget {
  const settingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //change your color here
        ),
        title: Center(child: appBarText("설정")),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: [
          Container(width:52)
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(24, 38, 24, 24),
        child: Container(
          child: Column(

            children: [
              versionDisplayWidget(),
              signOutButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}


Widget versionDisplayWidget(){
  return Container(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingNameText("버전"),
          ],
        ),
        settingDescriptionText("0.0.1"),
      ],
    ),
  );
}

Widget signOutButtonWidget(){
  return Container(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingNameText("로그아웃"),
          ],
        ),
        InkWell(
          onTap: () {
            Amplify.Auth.signOut().then((_) {
              Get.offAllNamed('/');
            });
          },
          child: Icon(
            Icons.logout,
            color: Colors.black,
          ),
        )
      ],
    ),
  );
}