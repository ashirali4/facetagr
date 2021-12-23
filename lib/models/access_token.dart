// To parse this JSON data, do
//
//     final accessTokenModel = accessTokenModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AccessTokenModel> accessTokenModelFromJson(String str) => List<AccessTokenModel>.from(json.decode(str).map((x) => AccessTokenModel.fromJson(x)));

String accessTokenModelToJson(List<AccessTokenModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccessTokenModel {
  AccessTokenModel({
    required this.accessToken,
    required this.postUrl,
  });

  String accessToken;
  String postUrl;

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) => AccessTokenModel(
    accessToken: json["AccessToken"] == null ? null : json["AccessToken"],
    postUrl: json["PostURL"] == null ? null : json["PostURL"],
  );

  Map<String, dynamic> toJson() => {
    "AccessToken": accessToken == null ? null : accessToken,
    "PostURL": postUrl == null ? null : postUrl,
  };
}
