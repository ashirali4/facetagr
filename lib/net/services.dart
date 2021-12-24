import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:facetagr/constants/endpoints.dart';
import 'package:facetagr/models/access_token.dart';
import 'package:facetagr/models/device_registration.dart';
import 'package:facetagr/models/firebase_token.dart';
import 'package:facetagr/utliz/data_storage.dart';
import 'package:facetagr/utliz/device_details.dart';
import 'package:facetagr/utliz/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

Future<dynamic> DeviceRegistrationAPI() async {
  var _content;
  bool _error = false;
  var details = await getDeviceDetails();
  Map map = {
    "DeviceUUID": details['id'],
    "DeviceName": details['name'],
    "DeviceType": details['type'],
    "DeviceModel": details['model'],
  };
  var body = jsonEncode(map);
  try {
    var url = Uri.parse(DEVICE_REGISTRATION);
    final response = await http
        .post(url, body: body, headers: {'Content-Type': 'application/json'});
    if (response != null) {
      if (response.statusCode == 200 && response.body != null) {
        List<DeviceRegistrationModel> deviceRegistrationresponse =
        deviceRegistrationModelFromJson(jsonDecode(response.body));
        _content = deviceRegistrationresponse;
        StoreDeviceRegisration(deviceRegistrationresponse[0].clientId, deviceRegistrationresponse[0].secretKey, details['id']);

      } else {
        _error = true;
        _content = response.body;
      }
    } else {
      _error = true;
    }
  } on SocketException {
    print(['deviceRegistration DioError']);
    _error = true;
    _content = 'Socket Exception';
  }
  return {"error": _error, "content": _content};
}

Future<dynamic> FirebaseTokenAPI() async {
  EasyLoading.show(status: 'Saving Token ...',);
  var _content;
  var _errorData='';
  bool _error = false;


  String time=DateTime.now().toUtc().toString();
  var data=await GetDeviceRegistraion();


  if(data['id']=='' || data['deviceId']=='' || data['secret']==''){
    DeviceRegistrationAPI();
  }else{
    var bytes1 = utf8.encode(data['id']+time+data['deviceId']+data['secret']);         // data being hashed
    Digest sha512Result = sha512.convert(bytes1);
    String? token = await FirebaseMessaging.instance.getToken();

    Map map = {
      "ClientID":data['id'],
      "UTCDateTime":time,
      "Hash":sha512Result.toString().toUpperCase(),
      "FireBaseAccessToken":token
    };

    var body = jsonEncode(map);
    print("Sending Token -- > ");
    print(token.toString());

    try {
      var url = Uri.parse(FIREBASE_TOKEN);
      final response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      if (response != null) {
        if (response.statusCode == 200 && response.body != null) {
          try{
            FirebaseToken firebaseToken =
            firebaseTokenFromJson(response.body);
            _content = firebaseToken.statusCode;
            _errorData= firebaseToken.responseMessage;

          }
          catch(e){
            _error = true;
            _content = response.body;
          }
        } else {
          _error = true;
          _content = response.body;
        }
      } else {
        _error = true;
      }
    } on SocketException {
      print(['deviceToken DioError']);
      _error = true;
      _content = 'Socket Exception';
    }
  }
  EasyLoading.dismiss();
  return {"error": _error, "content": _content , 'data' :_errorData};
}

Future<dynamic> AccessTokenAPI(String username,String password) async {
  EasyLoading.show(status: 'Authenticating ...',);
  var _content;
  bool _error = false;


  String time=DateTime.now().toUtc().toString();
  var data=await GetDeviceRegistraion();


  if(data['id']=='' || data['deviceId']=='' || data['secret']==''){
    DeviceRegistrationAPI();
  }else{
    var bytes1 = utf8.encode(data['id']+time+data['deviceId']+data['secret']);         // data being hashed
    Digest sha512Result = sha512.convert(bytes1);
    Map map = {
      "ClientID": data['id'],
      "UserName": username,
      "UserPassword":password,
      "UTCDateTime":time,
      "Hash":sha512Result.toString().toUpperCase()
    };

    var body = jsonEncode(map);
    print(body);

    try {
      var url = Uri.parse(DEVICE_TOKEN);
      final response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      if (response != null) {
        if (response.statusCode == 200 && response.body != null) {
          try{
            List<AccessTokenModel> accessTokenRespnse =
            accessTokenModelFromJson(jsonDecode(response.body));
            _content = accessTokenRespnse[0].postUrl+"?accesstoken="+accessTokenRespnse[0].accessToken;
            StoreURLToken(_content);
          }
          catch(e){

            _error = true;
            _content = response.body;
          }
        } else {
          _error = true;
          _content = response.body;
        }
      } else {
        _error = true;
      }
    } on SocketException {
      print(['deviceToken DioError']);
      _error = true;
      _content = 'Socket Exception';
    }
  }
  EasyLoading.dismiss();
  return {"error": _error, "content": _content};
}
