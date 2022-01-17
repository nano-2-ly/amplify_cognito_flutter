
import 'package:amplify_cognito_flutter/font/normal.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class settingScreen extends StatelessWidget {
  const settingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(24, 100, 24, 24),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              Get.toNamed('/');
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