import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_cognito_flutter/controller/deviceShadowController.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getDeviceList() async{
  var session = await Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true)) as CognitoAuthSession;

  var _currentUser = await Amplify.Auth.getCurrentUser();

  var deviceListURI =
  Uri.parse('https://6hlig5bzq0.execute-api.ap-northeast-2.amazonaws.com/default/iorilock-device-list');

  final response = await http.post(deviceListURI,
    headers: <String, String>{
      'Content-Type': 'application/json',
      "Accept": "*/*",
      'email': _currentUser.username,
      'AccessToken' : session.userPoolTokens!.accessToken.toString()
    },
    body: jsonEncode({
      'email': _currentUser.username,
      'AccessToken' : session.userPoolTokens!.accessToken.toString()
    }),
  );


  return jsonDecode(response.body);
}

Future<dynamic> getDeviceShadow(String uuid, bool useDeviceShadowController) async{
  var session = await Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true)) as CognitoAuthSession;

  var _currentUser = await Amplify.Auth.getCurrentUser();

  var deviceListURI =
  Uri.parse('https://6hlig5bzq0.execute-api.ap-northeast-2.amazonaws.com/default/iorilock-device-shadow');

  final response = await http.get(deviceListURI,
    headers: <String, String>{
      'Content-Type': 'application/json',
      "Accept": "*/*",
      'email': _currentUser.username,
      'AccessToken' : session.userPoolTokens!.accessToken.toString(),
      "device_uuid":uuid,
      "shadow_name":"status"
    },
  );

  if(useDeviceShadowController == true){
    final deviceShadow = Get.put(deviceShadowController());
    deviceShadow.alarmAllow.value = jsonDecode(response.body)["state"]["desired"]["alarmAllow"] as bool;
    deviceShadow.powerAlarmAllow.value = jsonDecode(response.body)["state"]["desired"]["powerAlarmAllow"] as bool;
    deviceShadow.monitorStartTime.value = jsonDecode(response.body)["state"]["desired"]["monitorStartTime"] as String;
    deviceShadow.monitorFinishTime.value = jsonDecode(response.body)["state"]["desired"]["monitorFinishTime"] as String;

  }

  return jsonDecode(response.body);
}

Future<dynamic> updateDeviceShadowDesired(String uuid, dynamic json ) async{
  var session = await Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true)) as CognitoAuthSession;

  var _currentUser = await Amplify.Auth.getCurrentUser();

  var deviceListURI =
  Uri.parse('https://6hlig5bzq0.execute-api.ap-northeast-2.amazonaws.com/default/iorilock-device-shadow');

  final response = await http.post(deviceListURI,
    headers: <String, String>{
      'Content-Type': 'application/json',
      "Accept": "*/*",
      'email': _currentUser.username,
      'AccessToken' : session.userPoolTokens!.accessToken.toString(),
      "device_uuid":uuid,
      "shadow_name":"status"
    },
    body: jsonEncode({
      "shadow_name":"status",
      "device_uuid":uuid,
      "payload":{
        "state":{
          "desired":json
        }
      }
    })
  );



  return jsonDecode(response.body);
}