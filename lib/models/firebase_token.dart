// To parse this JSON data, do
//
//     final firebaseToken = firebaseTokenFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FirebaseToken firebaseTokenFromJson(String str) => FirebaseToken.fromJson(json.decode(str));

String firebaseTokenToJson(FirebaseToken data) => json.encode(data.toJson());

class FirebaseToken {
  FirebaseToken({
    required this.statusCode,
    required this.responseMessage,
  });

  String statusCode;
  String responseMessage;

  factory FirebaseToken.fromJson(Map<String, dynamic> json) => FirebaseToken(
    statusCode: json["StatusCode"] == null ? null : json["StatusCode"],
    responseMessage: json["ResponseMessage"] == null ? null : json["ResponseMessage"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode == null ? null : statusCode,
    "ResponseMessage": responseMessage == null ? null : responseMessage,
  };
}
