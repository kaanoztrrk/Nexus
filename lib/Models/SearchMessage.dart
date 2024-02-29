import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SearchMessage {
  final String role;
  final List<SearchPart> parts;
  SearchMessage({
    required this.role,
    required this.parts,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'parts': parts.map((x) => x.toMap()).toList(),
    };
  }

  factory SearchMessage.fromMap(Map<String, dynamic> map) {
    return SearchMessage(
      role: map['role'] as String,
      parts: List<SearchPart>.from(
        (map['parts'] as List<int>).map<SearchPart>(
          (x) => SearchPart.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchMessage.fromJson(String source) =>
      SearchMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SearchPart {
  final String text;
  SearchPart({
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
    };
  }

  factory SearchPart.fromMap(Map<String, dynamic> map) {
    return SearchPart(
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchPart.fromJson(String source) =>
      SearchPart.fromMap(json.decode(source) as Map<String, dynamic>);
}
