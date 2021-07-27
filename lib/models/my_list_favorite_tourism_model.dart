// To parse this JSON data, do
//
//     final myListFavoriteTourismModel = myListFavoriteTourismModelFromJson(jsonString);

import 'dart:convert';

MyListFavoriteTourismModel myListFavoriteTourismModelFromJson(String str) =>
    MyListFavoriteTourismModel.fromJson(json.decode(str));

String myListFavoriteTourismModelToJson(MyListFavoriteTourismModel data) =>
    json.encode(data.toJson());

class MyListFavoriteTourismModel {
  MyListFavoriteTourismModel({
    required this.meta,
    required this.data,
  });

  Meta meta;
  List<Datum> data;

  factory MyListFavoriteTourismModel.fromJson(Map<String, dynamic> json) =>
      MyListFavoriteTourismModel(
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
    required this.category,
    required this.time,
    required this.address,
    required this.contact,
    required this.linkMaps,
    required this.pivot,
  });

  int id;
  String title;
  String description;
  String category;
  String time;
  String address;
  String contact;
  String linkMaps;
  Pivot pivot;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
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
        "category": category,
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
    required this.destinationId,
    required this.createdAt,
    required this.updatedAt,
  });

  int userId;
  int destinationId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        destinationId: json["destination_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "destination_id": destinationId,
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
