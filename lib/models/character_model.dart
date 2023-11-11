import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CharacterModel {
  final String name;
  final String? imageUrl;
  final String sourceUrl;
  CharacterModel({
    required this.name,
    this.imageUrl =
        'https://www.icegif.com/wp-content/uploads/2021/11/icegif-1427.gif',
    required this.sourceUrl,
  });

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      name: map['name'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      sourceUrl: map['sourceUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageUrl': imageUrl,
      'sourceUrl': sourceUrl,
    };
  }

  String toJson() => json.encode(toMap());

  factory CharacterModel.fromJson(String source) =>
      CharacterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
