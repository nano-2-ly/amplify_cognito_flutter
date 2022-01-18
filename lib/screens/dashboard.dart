import 'dart:convert';

import 'package:amplify_cognito_flutter/font/normal.dart';
import 'package:amplify_cognito_flutter/utils/deviceUtils.dart';
import 'package:amplify_cognito_flutter/widgets/deviceListWidget.dart';
import 'package:amplify_cognito_flutter/widgets/mainScreenCarouselWidget.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<AuthUser> getCurrentUser() async {
    var _currentUser = await Amplify.Auth.getCurrentUser();

    return _currentUser;
  }



  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //change your color here
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          Container(
            padding: EdgeInsets.all(16),
            child: InkWell(
              onTap: () {
                Get.toNamed('/setting');
              },
              child: Icon(
                Icons.settings,
                color: Color(0xff191919),
              ),
            ),
          )
        ],
      ),
      
      body: Container(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mainScreenCarouselWidget(),
              Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText("등록된 기기"),
                    FutureBuilder(
                        future: getCurrentUser(),
                        builder:
                            (BuildContext context, AsyncSnapshot<AuthUser> snapshot) {
                          if (snapshot.hasData == false) {
                            return CircularProgressIndicator();
                          }
                          //error가 발생하게 될 경우 반환하게 되는 부분
                          else if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                          }
                          // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                          else {
                            return Column(
                              children: [

                                SizedBox(
                                    height: 150, child: deviceListWidget()),
                              ],
                            );
                          }
                        }),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
