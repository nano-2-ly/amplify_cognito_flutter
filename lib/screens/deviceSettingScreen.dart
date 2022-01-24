import 'package:amplify_cognito_flutter/color/appColor.dart';
import 'package:amplify_cognito_flutter/controller/deviceShadowController.dart';
import 'package:amplify_cognito_flutter/controller/timePickerController.dart';
import 'package:amplify_cognito_flutter/font/normal.dart';
import 'package:amplify_cognito_flutter/utils/deviceUtils.dart';
import 'package:amplify_cognito_flutter/widgets/deviceListWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';


class deviceSettingScreen extends StatelessWidget {
  const deviceSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String startTimeValue = Get.arguments["deviceShadow"]["state"]["desired"]["workingStartTime"];
    String finishTimeValue = Get.arguments["deviceShadow"]["state"]["desired"]["workingFinishTime"];


    getDeviceShadow(Get.arguments["uuid"], true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //change your color here
        ),
        title: Center(child: appBarText("기기 설정")),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: [
          Container(width:52)
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(24, 30, 24, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            deviceIcon(Get.arguments['name'], Get.arguments['deviceShadow']['state']['reported']["isLocked"],Get.arguments['deviceShadow']['connection']['eventType']),

            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: Column(
                    children: [
                      alarmAllowCheckboxWidget(),
                      powerAlarmAllowCheckboxWidget(),

                      workingTimePickerWidget(startTimeValue,finishTimeValue ),

                    ],
                  )
                ),
                saveButtonWidget(Get.arguments["uuid"], Get.arguments['name'], startTimeValue, finishTimeValue)
              ],
            )
          ],
        ),
      ),
    );
  }
}


Widget alarmAllowCheckboxWidget(){
  final deviceShadow = Get.put(deviceShadowController());
  return Obx(()=>Container(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingNameText("알림 허용"),
            settingDescriptionText("모바일 앱에서 해당 기기에 대한 알림을 허용합니다."),
          ],
        ),
        Checkbox(
            value: deviceShadow.alarmAllow.value,
            onChanged: (value) {
              deviceShadow.alarmAllow.value = value!;
            }),
      ],
    ),
  ));
}

Widget saveButtonWidget(uuid, name ,startTimeValue, finishTimeValue){
  final deviceShadow = Get.put(deviceShadowController());
  return Container(

    height: 50,
    color: mainPurpleColor,
    child: InkWell(
      child: Center(
        child: whiteColorInButtonText("저장"),
      ),
      onTap: (){
        dynamic deviceShadowJson={
          "workingStartTime":deviceShadow.workingStartTime.value,
          "workingFinishTime":deviceShadow.workingFinishTime.value,
          "alarmAllow": deviceShadow.alarmAllow.value,
          "powerAlarmAllow":deviceShadow.powerAlarmAllow.value
        };

        updateDeviceShadowDesired(uuid, deviceShadowJson);


        Get.back();


        Get.showSnackbar(
          GetBar(
            title: '저장되었습니다.',
            message: '${name}의 설정이 변경되었습니다.',
            duration: Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM,
          ),
        );


      },
    ),
  );
}

Widget powerAlarmAllowCheckboxWidget(){
  final deviceShadow = Get.put(deviceShadowController());
  return Obx(()=>Container(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingNameText("켜짐 알림"),
            settingDescriptionText("컴퓨터의 서버 연결 상태에 대한 알람을 허용합니다."),
          ],
        ),
        Checkbox(
            value: deviceShadow.powerAlarmAllow.value,
            onChanged: (value) {
              deviceShadow.powerAlarmAllow.value = value!;
            }),

      ],
    ),
  ));
}

Widget workingTimePickerWidget(startTimeValue, finishTimeValue){
  final deviceShadow = Get.put(deviceShadowController());

  return Obx(()=>Container(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingNameText("근무 시간"),
            settingDescriptionText("설정한 시간 외에 화면이 켜져 있으면 알림을 보냅니다."),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: (){
                DateTime parseDate =  DateTime.parse('2022-01-01T' + deviceShadow.workingStartTime.value.toString());
                Get.bottomSheet(
                    Container(
                      height: 300,
                      color: Colors.white,
                      child: Center(
                          child: TimePickerSpinner(
                            time: parseDate,
                            is24HourMode: false,
                            normalTextStyle: TextStyle(
                              fontSize: 18,
                            ),
                            highlightedTextStyle: TextStyle(
                              fontSize: 24,
                            ),
                            spacing: 20,
                            itemHeight: 30,
                            isForce2Digits: true,
                            onTimeChange: (time) {
                              print(time.hour);
                              print(time.minute);
                              print(time.second);

                              startTimeValue = time.hour.toString().padLeft(2, "0") +":"+time.minute.toString().padLeft(2, "0");
                              deviceShadow.workingStartTime.value = startTimeValue;

                            },
                          )),

                    )

                );
              },
              child: workingTimeText(deviceShadow.workingStartTime.value),
            ),

            Text(" ~ "),

            InkWell(
              onTap: (){

                DateTime parseDate =  DateTime.parse('2022-01-01T' + deviceShadow.workingFinishTime.value.toString());
                Get.bottomSheet(
                    Container(
                      height: 300,
                      color: Colors.white,
                      child: Center(
                          child: TimePickerSpinner(
                            time: parseDate,
                            is24HourMode: false,
                            normalTextStyle: TextStyle(
                              fontSize: 18,
                            ),
                            highlightedTextStyle: TextStyle(
                              fontSize: 24,
                            ),
                            spacing: 20,
                            itemHeight: 30,
                            isForce2Digits: true,
                            onTimeChange: (time) {
                              print(time.hour);
                              print(time.minute);
                              print(time.second);

                              startTimeValue = time.hour.toString().padLeft(2, "0") +":"+time.minute.toString().padLeft(2, "0");
                              deviceShadow.workingFinishTime.value = startTimeValue;

                            },
                          )),

                    )

                );
              },
              child: workingTimeText(deviceShadow.workingFinishTime.value),
            ),
          ],
        ),
      ],
    ),
  ));
}