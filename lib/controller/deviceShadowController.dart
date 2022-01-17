import 'package:get/get.dart';

class deviceShadowController extends GetxController{
  RxBool alarmAllow= true.obs;
  RxBool powerAlarmAllow= true.obs;
  RxString monitorStartTime = "".obs;
  RxString monitorFinishTime = "".obs;

}