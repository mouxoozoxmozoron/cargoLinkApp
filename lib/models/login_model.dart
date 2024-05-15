// To parse this JSON data, do
//
//     final Loginmodel = loginFromJson(jsonString);

import 'dart:convert';

Loginmodel loginFromJson(String str) => Loginmodel.fromJson(json.decode(str));

String loginToJson(Loginmodel data) => json.encode(data.toJson());

class Loginmodel {
  List<User>? user;
  String? token;

  Loginmodel({
    this.user,
    this.token,
  });

  factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
        user: json["user"] == null
            ? []
            : List<User>.from(json["user"]!.map((x) => User.fromJson(x))),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user == null
            ? []
            : List<dynamic>.from(user!.map((x) => x.toJson())),
        "token": token,
      };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? profileImage;
  String? userTypeId;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserType? userType;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profileImage,
    this.userTypeId,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        profileImage: json["profile_image"],
        userTypeId: json["user_type_id"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userType: json["user_type"] == null
            ? null
            : UserType.fromJson(json["user_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "profile_image": profileImage,
        "user_type_id": userTypeId,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_type": userType?.toJson(),
      };
}

class UserType {
  int? id;
  String? type;
  dynamic createdAt;
  dynamic updatedAt;

  UserType({
    this.id,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        id: json["id"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

