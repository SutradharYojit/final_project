//This Blog Data model, us to get the data from api

class BlogDataModel {
  int? id;
  Attributes? attributes;

  BlogDataModel({this.id, this.attributes});

  BlogDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}
// this model give the information of blog data to attributes
class Attributes {
  String? title;
  String? description;
  String? imageUrl;
  String? authorId;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  Attributes(
      {this.title,
        this.description,
        this.imageUrl,
        this.authorId,
        this.createdAt,
        this.updatedAt,
        this.publishedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    authorId = json['authorId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['authorId'] = this.authorId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    return data;
  }
}
