import 'dart:convert';

class FirebaseBookModel {
  String id;
  String medium;
  String authors;
  String title;
  String previewLink;
  FirebaseBookModel({
    this.id,
    this.medium,
    this.authors,
    this.title,
    this.previewLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medium': medium,
      'authors': authors,
      'title': title,
      'previewLink': previewLink,
    };
  }

  factory FirebaseBookModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FirebaseBookModel(
      id: map['id'],
      medium: map['medium'],
      authors: map['authors'],
      title: map['title'],
      previewLink: map['previewLink'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseBookModel.fromJson(String source) =>
      FirebaseBookModel.fromMap(json.decode(source));
}
