import 'package:mongo_dart/mongo_dart.dart';

class Quote {
  final ObjectId id;
  final String text;
  final String author;
  final bool isFavorite;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    this.isFavorite = false,
  });

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['_id'] as ObjectId,
      text: map['text'] as String,
      author: map['author'] as String,
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'text': text,
      'author': author,
      'isFavorite': isFavorite,
    };
  }
}
