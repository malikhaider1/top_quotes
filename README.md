# Top Quotes App

A cross-platform mobile application built with Flutter for displaying and managing inspiring quotes.

## Key Features & Benefits
*   **Clean Architecture:** Complete App is created with clean architecture and focused on main aspects which are required although this is not based on featured based architecture because of few functionalities.
*   **Bloc:** Bloc State Management is used.
*   **Rest Api:** FavQs Api is used along with Random Word Api hosting on our main server which show image of words with interesting definition of each.
*   **Daily Quote:** Get a fresh dose of inspiration with a new quote every day.
*   **Quote Categories:** Browse quotes by different categories such as motivation, success, and love.
*   **Favorite Quotes:** Save your favorite quotes for easy access.
*   **Search Functionality:** Quickly find quotes by keywords or author , even with tags.
*   **Cross-Platform Compatibility:** Runs seamlessly on Android, iOS, Web, macOS, Linux, and Windows.

## Prerequisites & Dependencies

Before you begin, ensure you have the following installed:

*   **Flutter SDK:** Follow the official Flutter installation guide: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
*   **Android Studio or Xcode:** For running the app on emulators or physical devices.
*   **Dart SDK:** Included with Flutter.
*   **C++ Compiler**: Needed for some plugin dependencies
*   **Swift**: Needed for iOS specific components.

## Installation & Setup Instructions

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/malikhaider1/top_quotes.git
    cd top_quotes
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the app:**

    ```bash
    flutter run
    ```

    Choose the target platform (Android, iOS, Web, macOS, Linux, or Windows).

## Usage Examples & API Documentation

### Example: Fetching a Daily Quote

This app primarily utilizes local data, so there is no direct API documentation. However, here's an example showcasing how quotes are managed within the Flutter application:

```dart
// Example usage in lib/ui/quote_of_the_day/quote_of_the_day_screen.dart

import 'package:flutter/material.dart';
import 'package:top_quotes/domain/entities/quote.dart'; // Assuming a Quote entity exists

class QuoteOfTheDayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate fetching a quote for demonstration purposes
    Quote dailyQuote = Quote(author: "Nelson Mandela", text: "The greatest glory in living lies not in never falling, but in rising every time we fall.");

    return Scaffold(
      appBar: AppBar(title: Text('Quote of the Day')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dailyQuote.text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                '- ${dailyQuote.author}',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

## Configuration Options

You can customize the app's behavior through the `pubspec.yaml` file and within the application's settings:

*   **Theme Customization:**  Modify the app's theme using Flutter's themeing capabilities in `lib/core/theme/`.
*   **Database Configuration:** The app uses a local database. The location and configuration details can be adjusted within the `lib/data/local_db/` directory.

## Contributing Guidelines

We welcome contributions to the Top Quotes App!  Please follow these guidelines:

1.  **Fork the repository.**
2.  **Create a new branch for your feature or bug fix:** `git checkout -b feature/your-feature-name` or `git checkout -b bugfix/your-bug-fix`.
3.  **Make your changes and commit them with clear, concise messages.**
4.  **Test your changes thoroughly.**
5.  **Submit a pull request to the `main` branch.**

## License Information

The license for this project is not currently specified. All rights are reserved unless otherwise stated.

## Acknowledgments

*   Flutter: For providing the framework for building cross-platform applications.
*   Inspiration from various open-source Flutter projects.
