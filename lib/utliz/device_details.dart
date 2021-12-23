import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<dynamic> getDeviceDetails() async {
  String? id='';
  String? deviceName='';
  String? deviceType='';
  String? deviceModel='';


  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    id = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    deviceName= iosDeviceInfo.name;
    deviceType = 'IOS';
    deviceModel = iosDeviceInfo.model;
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    id =  androidDeviceInfo.androidId; // unique ID on iOS
    deviceName= androidDeviceInfo.device;
    deviceType = 'Android';
    deviceModel = androidDeviceInfo.model;
  }

  print("DEVICE ID -- > " + id.toString());
  print("DEVICE NAME -- > " + deviceName.toString());
  print("DEVICE TYPE -- > " + deviceType.toString());
  print("DEVICE MODEL -- > " + deviceModel.toString());

  return {
    'id':id,
    'name' : deviceName,
    'type' : deviceType,
    'model': deviceModel
  };
}