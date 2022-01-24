import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_cognito_flutter/analytics_service.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:http/http.dart' as http;

import '../analytics_events.dart';


void lockScreen(String uuid, String key) async {
  var session = await Amplify.Auth.fetchAuthSession(
      options: CognitoSessionOptions(getAWSCredentials: true))
  as CognitoAuthSession;

  var _currentUser = await Amplify.Auth.getCurrentUser();

  var mqttPublishURI = Uri.parse(
      'https://6hlig5bzq0.execute-api.ap-northeast-2.amazonaws.com/default/iorilock-mqtt-publish');

  final response = await http.post(
    mqttPublishURI,
    headers: <String, String>{
      'Content-Type': 'application/json',
      "Accept": "*/*",
      'email': _currentUser.username,
      'AccessToken': session.userPoolTokens!.accessToken.toString()
    },
    body: jsonEncode({
      "device_uuid": uuid,
      "key": key,
      "lock": true
    }),
  );

  AnalyticsService.log(DeviceLockEvent());
  print(response.body);
}