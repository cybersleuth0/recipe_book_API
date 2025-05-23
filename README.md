
# Flutter Recipe Book App with REST API

![Flutter](https://img.shields.io/badge/Flutter-3.7.2-blue)
![Dart](https://img.shields.io/badge/Dart-3.7.2-blue)
![License](https://img.shields.io/badge/License-MIT-green)

A beautiful Flutter application that fetches and displays recipes from a REST API, using modern UI elements and seamless cross-platform support (mobile and desktop).

## Features

* 🍲 Browse a collection of recipes via API
* 🎨 Material 3 UI design
* 🔎 Search and filter recipes
* 🚦 Error handling with retry support
* 🌈 Themed with custom fonts and colors

## Screenshots

| Homepage                                   | SearchPage                                   | DetailsPage                                 |
| ----------------------------------------------- | --------------------------------------------- | ---------------------------------------------- |
| <img src="screenshot/Screenshot 2025-05-21 154747.png" width="200"> | <img src="screenshot/Screenshot 2025-05-23 123041.png" width="200"> | <img src="screenshot/Screenshot 2025-05-23 123105.png" width="200"> |

## API Overview

This app interacts with a recipes REST API to fetch and display a list of sample recipes.

* **Endpoint:** `https://dummyjson.com/recipes`

## Getting Started

### Prerequisites

* Flutter SDK (>=3.7.2)
* Dart (>=3.7.2)
* An IDE (Android Studio, VS Code, etc.)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/cybersleuth0/recipe_book_API.git
   ```
2. Navigate to the project directory:

   ```bash
   cd recipe_book_API
   ```
3. Install dependencies:

   ```bash
   flutter pub get
   ```
4. Run the app:

   ```bash
   flutter run
   ```

## Project Structure

```text
lib/
├── main.dart             # App entry point
├── App Constant/         # Route and constant definitions
├── screens/              # UI screens for recipes
└── model/                # Data models for recipes
```

## Dependencies

* [http](https://pub.dev/packages/http) – HTTP client for API requests
* [google_fonts](https://pub.dev/packages/google_fonts) – Custom fonts
* [flutter](https://flutter.dev) – UI toolkit

---

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/cybersleuth0/recipe_book_API.git
git push -u origin main
```

---
