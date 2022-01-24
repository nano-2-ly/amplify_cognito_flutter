import 'package:amplify_cognito_flutter/font/normal.dart';
import 'package:amplify_cognito_flutter/utils/deviceUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';





class deviceListWidget extends StatelessWidget {
  const deviceListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getDeviceList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
            if (snapshot.hasData == false) {
              return Center(child: SizedBox(height: 20, width:20,child: CircularProgressIndicator()));
            }
            //error가 발생하게 될 경우 반환하게 되는 부분
            else if (snapshot.hasError) {
              print("snapshot.error");
              print(snapshot.error);
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
              return Container(

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(0,0,8,0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {

                    String device_uuid = snapshot.data[index].keys.toList()[0];

                    return deviceButtonWidget(device_uuid, snapshot.data[index][device_uuid]);
                  },
                ),
              );

            }
          }
        ),
    );
  }
}




Widget deviceButtonWidget(String uuid, String key){
  return Container(

    child: Column(
      children: [

        FutureBuilder(
            future: getDeviceShadow(uuid, false),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
              if (snapshot.hasData == false) {
                return Container(width:20, height: 20, child: CircularProgressIndicator());
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                print("snapshot.error");
                print(snapshot.error);
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
                print(":d");
                print(snapshot.data["connection"]);
                if(snapshot.data["connection"] == false){
                  snapshot.data["connection"] = {"eventType" : "disconnected"};
                }
                return InkWell(
                  onTap: (){
                    Get.toNamed("/device", arguments: {"uuid":uuid, "key" : key, "name":snapshot.data["state"]["desired"]["name"].toString(), "deviceShadow": snapshot.data});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        deviceIcon(snapshot.data["state"]["desired"]["name"].toString(), snapshot.data["state"]["reported"]["isLocked"].toString(),snapshot.data["connection"]["eventType"].toString())
                      ],
                    ),
                  ),
                );

              }
            }
        )
      ],
    ),
  );
}

Widget deviceIcon(String name, String islocked, String connection){
  String image_path = "";

  print("connection??:");
  print(connection);
  if (connection == null){
    connection = "disconnected";
  }

  if(connection != "connected"){
    image_path = "assets/images/desktop_normal.png";
  }
  else{
    if(islocked == "locked"){
      image_path = "assets/images/desktop_locked.png";
    }
    else{
      image_path = "assets/images/desktop_unlocked.png";
    }
  }

  return Column(
    children: [

      Image.asset(image_path, width: 81,height: 71,),
      Container(
        child: deviceNameText(name),
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      ),

    ],
  );
}