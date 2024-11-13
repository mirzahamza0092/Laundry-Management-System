// To parse this JSON data, do
//
//     final loginScreenModel = loginScreenModelFromJson(jsonString);

import 'dart:convert';

LoginScreenModel loginScreenModelFromJson(String str) => LoginScreenModel.fromJson(json.decode(str));

String loginScreenModelToJson(LoginScreenModel data) => json.encode(data.toJson());

class LoginScreenModel {
    String token;
    String role;

    LoginScreenModel({
        required this.token,
        required this.role,
    });

    factory LoginScreenModel.fromJson(Map<String, dynamic> json) => LoginScreenModel(
        token: json["token"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "role": role,
    };
}
