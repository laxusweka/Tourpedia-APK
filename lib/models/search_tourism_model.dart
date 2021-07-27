// To parse this JSON data, do
//
//     final searchTourismModel = searchTourismModelFromJson(jsonString);

import 'dart:convert';

SearchTourismModel searchTourismModelFromJson(String str) =>
    SearchTourismModel.fromJson(json.decode(str));

String searchTourismModelToJson(SearchTourismModel data) =>
    json.encode(data.toJson());

class SearchTourismModel {
  SearchTourismModel({
    required this.meta,
    required this.data,
  });

  Meta meta;
  Data data;

  factory SearchTourismModel.fromJson(Map<String, dynamic> json) =>
      SearchTourismModel(
        meta: Meta.fromJson(json["meta"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.data,
  });

  List<Datum> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
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
    required this.images,
  });

  int id;
  String title;
  String description;
  String category;
  String time;
  String address;
  String contact;
  String linkMaps;
  List<Image> images;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        time: json["time"],
        address: json["address"],
        contact: json["contact"],
        linkMaps: json["link_maps"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
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
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    required this.id,
    required this.linkImage,
  });

  int id;
  String linkImage;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        linkImage: json["link_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link_image": linkImage,
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
