// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CustommerOrder custommerorderFromJson(String str) => CustommerOrder.fromJson(json.decode(str));

String welcomeToJson(CustommerOrder data) => json.encode(data.toJson());

class CustommerOrder {
    List<Order>? order;

    CustommerOrder({
        this.order,
    });

    factory CustommerOrder.fromJson(Map<String, dynamic> json) => CustommerOrder(
        order: json["order"] == null ? [] : List<Order>.from(json["order"]!.map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order": order == null ? [] : List<dynamic>.from(order!.map((x) => x.toJson())),
    };
}

class Order {
    int? id;
    String? status;
    String? position;
    int? userId;
    String? destination;
    int? driverId;
    int? transportationCompaniesId;
    String? receiptImage;
    String? cargoImage;
    String? quantity;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;
    TransportationCompany? transportationCompany;
    Driver? driver;

    Order({
        this.id,
        this.status,
        this.position,
        this.userId,
        this.destination,
        this.driverId,
        this.transportationCompaniesId,
        this.receiptImage,
        this.cargoImage,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.transportationCompany,
        this.driver,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        status: json["status"],
        position: json["position"],
        userId: json["user_id"],
        destination: json["destination"],
        driverId: json["driver_id"],
        transportationCompaniesId: json["transportation_companies_id"],
        receiptImage: json["receipt_image"],
        cargoImage: json["cargo_image"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        transportationCompany: json["transportation_company"] == null ? null : TransportationCompany.fromJson(json["transportation_company"]),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "position": position,
        "user_id": userId,
        "destination": destination,
        "driver_id": driverId,
        "transportation_companies_id": transportationCompaniesId,
        "receipt_image": receiptImage,
        "cargo_image": cargoImage,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "transportation_company": transportationCompany?.toJson(),
        "driver": driver?.toJson(),
    };
}

class Driver {
    int? id;
    String? userId;
    String? transportationCompanyId;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;

    Driver({
        this.id,
        this.userId,
        this.transportationCompanyId,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        userId: json["user_id"],
        transportationCompanyId: json["transportation_company_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "transportation_company_id": transportationCompanyId,
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    });

    factory TransportationCompany.fromJson(Map<String, dynamic> json) => TransportationCompany(
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    };
}
