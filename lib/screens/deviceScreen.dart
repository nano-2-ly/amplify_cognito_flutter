import 'package:amplify_cognito_flutter/font/normal.dart';
import 'package:amplify_cognito_flutter/utils/deviceUtils.dart';
import 'package:amplify_cognito_flutter/utils/lockUtils.dart';
import 'package:amplify_cognito_flutter/widgets/deviceListWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class deviceScreen extends StatelessWidget {
  const deviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(24, 100, 24, 150),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            deviceIcon(Get.arguments['name']),

            Container(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  lockButtonWidget(Get.arguments['uuid']),
                  deviceSettingButtonWidget(Get.arguments['uuid']),
                  deviceDeleteButtonWidget(),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


Widget lockButtonWidget(String uuid){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingNameText("기기 잠금"),
            settingDescriptionText("스위치로 화면을 잠금할 수 있습니다."),
          ],
        ),
        InkWell(

          child: Icon(Icons.lock_outline_rounded),
          onTap: () async{
            lockScreen(uuid);
          },
        ),
      ],
    ),
  );
}

Widget deviceSettingButtonWidget(String uuid){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingNameText("기기 설정"),
            settingDescriptionText("기기 설정 페이지로 이동합니다."),
          ],
        ),
        InkWell(
          child: Icon(Icons.settings),
          onTap: () async{
            Get.toNamed("/device/setting", arguments:Get.arguments);
          },
        ),
      ],
    ),
  );
}

Widget deviceDeleteButtonWidget(){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingNameText("기기 삭제"),
            settingDescriptionText("이 기기를 삭제합니다."),
          ],
        ),
        InkWell(
          child: Icon(Icons.cancel_outlined),
          onTap: () async{
            Get.bottomSheet(
                Container(
                  height: 300,
                  color: Colors.white,
                  child: Center(child: Text("hello")),
                )
            );
          },
        ),
      ],
    ),
  );

}