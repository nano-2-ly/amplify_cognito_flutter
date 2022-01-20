import 'package:amplify_cognito_flutter/color/appColor.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //change your color here
        ),
        title: Center(child: appBarText("등록된 기기")),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: [
          Container(width:52)
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(24, 10, 24, 150),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            deviceIcon(Get.arguments['name']),

            Container(

              child: Column(

                children: [
                  lockButtonWidget(Get.arguments['uuid'], Get.arguments['name'], Get.arguments['key']),
                  deviceSettingButtonWidget(Get.arguments['uuid']),
                  deviceDeleteButtonWidget(Get.arguments['uuid'], Get.arguments['name']),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


Widget lockButtonWidget(String uuid, String name, String key){
  return Container(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
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
            lockScreen(uuid, key);

            Get.showSnackbar(
              GetBar(
                title: '잠금되었습니다.',
                message: '${name}는 이제 안전합니다.😀',
                duration: Duration(seconds: 2),
                snackPosition: SnackPosition.BOTTOM,
              ),
            );

          },
        ),
      ],
    ),
  );
}

Widget deviceSettingButtonWidget(String uuid){
  return Container(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
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

Widget deviceDeleteButtonWidget(String uuid, String name){
  return Container(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            redSettingNameText("기기 삭제"),
            redSettingDescriptionText("이 기기를 삭제합니다."),
          ],
        ),
        InkWell(
          child: Icon(Icons.cancel_outlined, color: alertColor,),
          onTap: () async{
            Get.bottomSheet(

                Container(
                  height: 200,
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      alertBottomSheetDescriptionText("기기를 삭제하면 더이상 컴퓨터를 지켜낼 수 없습니다. 정말로 삭제하시겠습니까?"),
                      deviceDeleteConfirmButtonWidget(uuid, name),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    )
                )
            );
          },
        ),
      ],
    ),
  );

}

Widget deviceDeleteConfirmButtonWidget(uuid, name){

  return Container(

    height: 50,
    color: alertColor,
    child: InkWell(
      child: Center(
        child: whiteColorInButtonText("삭제"),
      ),
      onTap: (){
        Get.back();

        Get.showSnackbar(
          GetBar(
            title: '삭제되었습니다.',
            message: '${name}이 계정에서 삭제되었습니다.',
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
          ),
        );


      },
    ),
  );
}