// To parse this JSON data, do
//
// final comapny = companyFromJson(jsonString);

import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  List<TransportationCompany>? transportationCompanies;

  Company({
    this.transportationCompanies,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        transportationCompanies: json["transportation_companies"] == null
            ? []
            : List<TransportationCompany>.from(json["transportation_companies"]!
                .map((x) => TransportationCompany.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transportation_companies": transportationCompanies == null
            ? []
            : List<dynamic>.from(
                transportationCompanies!.map((x) => x.toJson())),
      };
}

class TransportationCompany {
  int? id;
  String? name;
  String? userId;
  String? contact;
  String? email;
  String? bankAcountNumber;
  String? bankType;
  String? agentLogo;
  String? location;
  String? companyCategory;
  String? workingDay;
  String? routes;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isdisplayingdetails;
  User? user;

  TransportationCompany({
    this.id,
    this.name,
    this.userId,
    this.contact,
    this.email,
    this.bankAcountNumber,
    this.bankType,
    this.agentLogo,
    this.location,
    this.companyCategory,
    this.workingDay,
    this.routes,
    this.createdAt,
    this.updatedAt,
    this.isdisplayingdetails = false,
    this.user,
  });

  factory TransportationCompany.fromJson(Map<String, dynamic> json) =>
      TransportationCompany(
        id: json["id"],
        name: json["name"],
        userId: json["user_id"],
        contact: json["contact"],
        email: json["email"],
        bankAcountNumber: json["bank_acount_number"],
        bankType: json["bank_type"],
        agentLogo: json["agent_logo"],
        location: json["location"],
        companyCategory: json["company_category"],
        workingDay: json["working_day"],
        routes: json["routes"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        isdisplayingdetails: json["is_commenting"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "contact": contact,
        "email": email,
        "bank_acount_number": bankAcountNumber,
        "bank_type": bankType,
        "agent_logo": agentLogo,
        "location": location,
        "company_category": companyCategory,
        "working_day": workingDay,
        "routes": routes,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
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
      };
}
