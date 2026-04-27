import 'package:mongo_dart/mongo_dart.dart';
import '../models/quote.dart';

class MongoService {
  static late Db db;
  static late DbCollection collection;

  static Future<void> connect() async {
    const String uri = 'mongodb+srv://mahmoud:1234@cluster0.q1nqq3s.mongodb.net/quotes_db?appName=Cluster0';
    db = await Db.create(uri);
    await db.open();
    collection = db.collection('quotes');
  }

  static Future<List<Quote>> getQuotes() async {
    try {
      final quotesList = await collection.find().toList();
      return quotesList.map((q) => Quote.fromMap(q)).toList();
    } catch (e) {
      print('Error fetching quotes: $e');
      return [];
    }
  }

  static Future<void> addQuote(String text, String author) async {
    final quote = Quote(
      id: ObjectId(),
      text: text,
      author: author,
      isFavorite: false,
    );
    await collection.insert(quote.toMap());
  }

  static Future<void> deleteQuote(ObjectId id) async {
    await collection.remove(where.id(id));
  }

  static Future<void> toggleFavorite(Quote quote) async {
    await collection.update(
      where.id(quote.id),
      modify.set('isFavorite', !quote.isFavorite),
    );
  }
}
