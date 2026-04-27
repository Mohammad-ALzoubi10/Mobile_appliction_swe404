import 'package:flutter/material.dart';
import 'database/mongo_service.dart';
import 'models/quote.dart';
import 'quote_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await MongoService.connect();
  } catch (e) {
    print('Failed to connect to MongoDB: $e');
  }
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: QuoteList(),
  ));
}

class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuotes();
  }

  Future<void> _fetchQuotes() async {
    setState(() {
      isLoading = true;
    });
    final fetchedQuotes = await MongoService.getQuotes();
    setState(() {
      quotes = fetchedQuotes;
      isLoading = false;
    });
  }

  void _showAddQuoteDialog() {
    final textController = TextEditingController();
    final authorController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFD93D),
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 3),
            borderRadius: BorderRadius.zero,
          ),
          title: const Text(
            'ADD A QUOTE',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Quote Text',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.zero,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(
                  labelText: 'Author',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.zero,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(3, 3))
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4D96FF),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () async {
                  if (textController.text.isNotEmpty && authorController.text.isNotEmpty) {
                    await MongoService.addQuote(textController.text, authorController.text);
                    Navigator.pop(context);
                    _fetchQuotes();
                  }
                },
                child: const Text('SAVE', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F0),
      appBar: AppBar(
        title: const Text(
          'RAW QUOTES',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF6B6B),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3.0),
          child: Container(
            color: Colors.black,
            height: 3.0,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 4,
              ),
            )
          : quotes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'NO QUOTES YET.',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Hit the + button to add one!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  color: Colors.black,
                  backgroundColor: const Color(0xFFFFD93D),
                  onRefresh: _fetchQuotes,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      return QuoteCard(
                        quote: quotes[index],
                        onDelete: () async {
                          await MongoService.deleteQuote(quotes[index].id);
                          _fetchQuotes();
                        },
                        onToggleFavorite: () async {
                          await MongoService.toggleFavorite(quotes[index]);
                          _fetchQuotes();
                        },
                      );
                    },
                  ),
                ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF6BCB77),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(4, 4),
            )
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.black, size: 30),
          onPressed: _showAddQuoteDialog,
          tooltip: 'Add Quote',
        ),
      ),
    );
  }
}
