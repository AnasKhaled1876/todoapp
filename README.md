# 📝 Todo List App with Bilingual Support 🇺🇸🇸🇦

A clean, user-friendly Todo List application built with Flutter, supporting both English and Arabic. This app is designed with best practices in mind, ensuring a modern UI, responsive experience, and scalable code architecture.

## ✨ Features

- ✅ **Task Management**  
  Add, view, complete, and delete todo items with ease.

- 🌍 **Bilingual Support**  
  Switch between **English** and **Arabic** using an in-app language toggle.

- 📱 **Responsive Design**  
  Fully optimized for both mobile and tablet screens.

- 🎨 **Modern UI**  
  Built using Flutter's Material Design with a clean and intuitive interface.

- 🧠 **State Management with Riverpod**  
  Efficient and scalable app state handling using `flutter_riverpod`.

- 🌐 **Localization with Easy Localization**  
  Supports multilingual content using the `easy_localization` package.

- 📭 **Empty State Handling**  
  Displays helpful messages and action prompts when no tasks exist.

## 🧱 Architecture

This app follows a **clean architecture** structure, clearly separating:

- **UI Layer**: Screens and widgets  
- **Business Logic Layer**: ViewModels and providers  
- **Data Layer**: Models and local storage access

This separation allows better scalability, testing, and maintainability.

## 📸 Screenshots

| Light Mode | Arabic Support |
|------------|----------------|
| ![Light](screenshots/light.png) | ![Arabic](screenshots/arabic.png) |

> *Screenshots are for demonstration. Replace with actual images from your app.*

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Dart enabled IDE (VS Code / Android Studio)

### Installation

```bash
git clone https://github.com/your-username/todo-bilingual-app.git
cd todo-bilingual-app
flutter pub get
flutter run
```

Localization Setup

This app uses easy_localization. To add more languages:

1. Add ARB files in assets/translations/.
2. Update supported locales in main.dart.
3. Use tr() for all translatable strings.

📁 Project Structure

```bash
lib/
│
├── main.dart
├── core/
│   └── theme.dart
├── features/
│   ├── todo/
│   │   ├── models/
│   │   ├── views/
│   │   ├── providers/
│   │   └── widgets/
├── l10n/
│   └── en.json
│   └── ar.json
```

🧩 Packages Used
•flutter_riverpod
•easy_localization
•flutter_hooks
•intl

📄 License

This project is licensed under the MIT License.

⸻

Built with Flutter

---

Let me know if you'd like it tailored for publishing on **pub.dev**, **GitHub Pages**, or to include installation as a **PWA or APK**.
