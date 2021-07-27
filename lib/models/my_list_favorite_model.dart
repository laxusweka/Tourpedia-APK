// To parse this JSON data, do
//
//     final myListFavoriteModel = myListFavoriteModelFromJson(jsonString);

import 'dart:convert';

MyListFavoriteModel myListFavoriteModelFromJson(String str) =>
    MyListFavoriteModel.fromJson(json.decode(str));

String myListFavoriteModelToJson(MyListFavoriteModel data) =>
    json.encode(data.toJson());

class MyListFavoriteModel {
  MyListFavoriteModel({
    required this.meta,
    required this.data,
  });

  Meta meta;
  List<Datum> data;

  factory MyListFavoriteModel.fromJson(Map<String, dynamic> json) =>
      MyListFavoriteModel(
        meta: Meta.fromJson(json["meta"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.time,
    required this.address,
    required this.contact,
    required this.linkMaps,
    required this.pivot,
  });

  int id;
  String title;
  String description;
  String price;
  String time;
  String address;
  String contact;
  String linkMaps;
  Pivot pivot;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        time: json["time"],
        address: json["address"],
        contact: json["contact"],
        linkMaps: json["link_maps"],
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "time": time,
        "address": address,
        "contact": contact,
        "link_maps": linkMaps,
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  Pivot({
    required this.userId,
    required this.culinaryId,
    required this.createdAt,
    required this.updatedAt,
  });

  int userId;
  int culinaryId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        culinaryId: json["culinary_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "culinary_id": culinaryId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Meta {
  Meta({
    required this.code,
    required this.status,
    required this.message,
  });

  int code;
  String status;
  String message;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        code: json["code"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
      };
}
