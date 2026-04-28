# 📝 Raw Quotes


## 📱 Screenshots

| Home (Empty) | Add a Quote |
|---|---|
| <img width="405" height="810" alt="image" src="https://github.com/user-attachments/assets/807715c8-6ac6-4857-b8ff-e966b7cd77a2" />
 <img width="401" height="805" alt="image" src="https://github.com/user-attachments/assets/fa02d708-1a4b-4d04-a021-ab1e13831995" />


---

## ✨ Features

- 📖 View all saved quotes in a clean list
- ➕ Add new quotes with text and author
- ❤️ Mark quotes as favorites
- 🗑️ Delete quotes
- 🔄 Pull-to-refresh
- ☁️ Cloud storage with MongoDB Atlas (real-time sync)

---

## 🗂️ Project Structure

```
lib/
├── main.dart               # App entry point & QuoteList UI
├── quote_card.dart         # Individual quote card widget
├── models/
│   └── quote.dart          # Quote data model
└── database/
    └── mongo_service.dart  # MongoDB connection & CRUD operations
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.x or later)
- A [MongoDB Atlas](https://www.mongodb.com/cloud/atlas) account
- Dart 3.x

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/raw-quotes.git
   cd raw-quotes
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure MongoDB**

   Open `lib/database/mongo_service.dart` and replace the connection URI with your own:
   ```dart
   const String uri = 'mongodb+srv://<username>:<password>@<cluster>.mongodb.net/quotes_db';
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## ⚙️ Dependencies

| Package | Purpose |
|---|---|
| `mongo_dart` | MongoDB driver for Dart |
| `flutter` | UI framework |

Add to your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  mongo_dart: ^0.9.0
```

---

## 🔐 Environment & Security

> ⚠️ **Never commit your MongoDB credentials to GitHub.**

Consider using a `.env` file or Flutter's `--dart-define` flags to store secrets:

```bash
flutter run --dart-define=MONGO_URI=your_connection_string
```

And add `.env` to your `.gitignore`:
```
.env
```

---

## 🎨 Design

Raw Quotes uses a **neo-brutalist** design language:
- Bold black borders and hard shadows
- High-contrast accent colors (coral red, yellow, blue, green)
- All-caps typography for headers
- Zero border radius on interactive elements

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you'd like to change.

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

> Made with ❤️ using Flutter & MongoDB
