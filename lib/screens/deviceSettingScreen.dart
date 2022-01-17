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
    String startTimeValue = Get.arguments["deviceShadow"]["state"]["desired"]["monitorStartTime"];
    String finishTimeValue = Get.arguments["deviceShadow"]["state"]["desired"]["monitorFinishTime"];


    getDeviceShadow(Get.arguments["uuid"], true);
    return Scaffold(

      body: Container(
        padding: EdgeInsets.fromLTRB(24, 100, 24, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            deviceIcon(Get.arguments['name']),

            Column(
              children: [
                Container(
                  height: 250,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      alarmAllowCheckboxWidget(),
                      powerAlarmAllowCheckboxWidget(),

                      workingTimePickerWidget(startTimeValue,finishTimeValue ),

                    ],
                  )
                ),
                saveButtonWidget(Get.arguments["uuid"], startTimeValue, finishTimeValue)
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

Widget saveButtonWidget(uuid, startTimeValue, finishTimeValue){
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
          "monitorStartTime":startTimeValue,
          "monitorFinishTime":finishTimeValue,
          "alarmAllow": deviceShadow.alarmAllow.value,
          "powerAlarmAllow":deviceShadow.powerAlarmAllow.value
        };

        updateDeviceShadowDesired(uuid, deviceShadowJson);
      },
    ),
  );
}

Widget powerAlarmAllowCheckboxWidget(){
  final deviceShadow = Get.put(deviceShadowController());
  return Obx(()=>Container(
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
                DateTime parseDate =  DateTime.parse('2022-01-01T' + startTimeValue.toString());
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
                              deviceShadow.monitorStartTime.value = startTimeValue;

                            },
                          )),

                    )

                );
              },
              child: workingTimeText(deviceShadow.monitorStartTime.value),
            ),

            Text(" ~ "),

            InkWell(
              onTap: (){

                DateTime parseDate =  DateTime.parse('2022-01-01T' + finishTimeValue.toString());
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
                              deviceShadow.monitorFinishTime.value = startTimeValue;

                            },
                          )),

                    )

                );
              },
              child: workingTimeText(deviceShadow.monitorFinishTime.value),
            ),
          ],
        ),
      ],
    ),
  ));
}