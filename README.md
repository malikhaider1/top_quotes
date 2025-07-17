# Top Quotes

<p align="center">
  <img src="assets/images/logo_removed.png" alt="App Screenshot" width="200" />
</p>

A beautiful, feature‑rich Flutter application that serves you inspiring quotes, random words with illustrations, and full user authentication & profile management. Built with clean architecture (core → data → domain → UI), BLoC state‑management, and a local/remote repository pattern.

---

## 🚀 Features

- **User Authentication**  
  - Sign Up, Login and Logout flows  
  - Profile management (view and edit)

- **Quotes**  
  - Browse all quotes in paginated lists  
  - “Quote of the Day” widget on the home screen  
  - Detailed quote view with author, category, and share & download options  
  - Mark quotes as “Favorite” and view your favorites list  

- **Random Word Explorer**  
  - Fetch a random word, see its definition & a curated illustration  
  - Option to download the illustration locally  

- **Search**  
  - Full-text search across quotes  

---

## 📦 Architecture & Folder Structure

```

lib/
├── core/                 # Themes, assets, utilities, failure handling
│   ├── theme/            # Colors, typography, sizes, AppTheme
│   ├── utils/            # Download image, gradient text, URL launcher
│   └── failure/          # Failure models & error handling
├── data/                 # Data sources & implementations
│   ├── models/           # JSON ↔ Dart model classes
│   ├── local\_db/         # Shared Preferences implementation
│   └── remote\_db/        # REST API repositories
├── domain/               # Business logic
│   ├── entities/         # Core entities (Quote, Profile, RandomWord…)
│   ├── repositories/     # Abstract contracts
│   └── use\_cases/        # Single-purpose interactors
├── ui/                   # Presentation layer (Widgets & Pages)
│   ├── widgets/          # Reusable UI components
│   ├── home/, login/, profile/, …
│   └── …                 # feature folders each with BLoC, events, states
└── main.dart             # App entry point & initialization

````

- **Clean Architecture**:  
  - Separation of concerns via `core`, `data`, `domain`, `ui`.  
  - Data flows: UI → BLoC → UseCase → Repository → Data Source.

- **State Management**:  
  - [flutter_bloc](https://pub.dev/packages/flutter_bloc) for all feature flows.  
  - Each feature has its own BLoC, Event, and State class.

---

## 🛠 Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) **≥ 3.7.0**  
- [Dart SDK](https://dart.dev/get-dart) **≥ 2.18.0**  
- A connected device or emulator (iOS, Android, Web, Desktop)

---

## ⚙️ Getting Started

1. **Clone the repo**  
   ```bash
   git clone https://github.com/malikhaider1/top_quotes.git
   cd top_quotes

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

4. **Generate serialization code** *(if you modify the models)*

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

---

## 🔌 Key Packages

| Package                | Purpose                               |
| ---------------------- | ------------------------------------- |
| flutter\_bloc          | BLoC state management                 |
| equatable              | Value equality for BLoC states/events |
| json\_serializable     | JSON ↔ Dart code generation           |
| dio                    | HTTP client                           |
| sharedPreferences      | local database for userToken          |
| cached\_network\_image | Image caching                         |
| url\_launcher          | Opening links & downloads             |
etc for other features and widgets
--
---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the project
2. Create your feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -am 'Add my feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Malik Haider**
✉️ [malikha499@gmail.com](mailto:malikha499@gmail.com)
📁 [GitHub/malikhaider1](https://github.com/malikhaider1)

Enjoy inspiring your users with every tap! 🚀


