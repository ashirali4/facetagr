

import 'package:meta/meta.dart';
import 'dart:convert';

List<DeviceRegistrationModel> deviceRegistrationModelFromJson(String str) => List<DeviceRegistrationModel>.from(json.decode(str).map((x) => DeviceRegistrationModel.fromJson(x)));

String deviceRegistrationModelToJson(List<DeviceRegistrationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeviceRegistrationModel {
  DeviceRegistrationModel({
    required this.deviceUuid,
    required this.clientId,
    required this.secretKey,
  });

  String deviceUuid;
  String clientId;
  String secretKey;

  factory DeviceRegistrationModel.fromJson(Map<String, dynamic> json) => DeviceRegistrationModel(
    deviceUuid: json["DeviceUUID"] == null ? null : json["DeviceUUID"],
    clientId: json["ClientID"] == null ? null : json["ClientID"],
    secretKey: json["SecretKey"] == null ? null : json["SecretKey"],
  );

  Map<String, dynamic> toJson() => {
    "DeviceUUID": deviceUuid == null ? null : deviceUuid,
    "ClientID": clientId == null ? null : clientId,
    "SecretKey": secretKey == null ? null : secretKey,
  };
}
