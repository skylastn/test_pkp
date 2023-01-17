// To parse this JSON data, do
//
//     final resourceModel = resourceModelFromJson(jsonString);

import 'dart:convert';

List<ResourceModel> resourceModelFromJson(String str) => List<ResourceModel>.from(json.decode(str).map((x) => ResourceModel.fromJson(x)));

String resourceModelToJson(List<ResourceModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class ResourceModel {
    ResourceModel({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    int? userId;
    int? id;
    String? title;
    String? body;

    factory ResourceModel.fromJson(Map<String, dynamic> json) => ResourceModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
