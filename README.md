# 🧾 Taxxon

> A smart, offline-first VAT management app built with Flutter — designed for UAE businesses to track VAT transactions, monitor tax obligations, and stay compliant with ease.

---

## ✨ Features

- **VAT Dashboard** — At-a-glance summary of Input VAT, Output VAT, and VAT Payable for the current quarter
- **Transaction Ledger** — Chronological list of purchase and sales transactions with Before Tax, After Tax, and Tax Amount breakdowns
- **Quarterly Reporting** — Filter and download tax summaries by quarter
- **Secure Authentication** — Local user login and registration backed by SQLite
- **Offline-First** — All data stored locally on the device using `sqflite`; no internet required
- **Smooth Navigation** — Animated screen transitions and bottom navigation between Dashboard and Profile
- **Reactive State Management** — Powered by Riverpod for predictable, testable state

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | [Flutter](https://flutter.dev/) (SDK `^3.10.7`) |
| Language | Dart |
| State Management | [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) `^2.4.9` |
| Local Database | [sqflite](https://pub.dev/packages/sqflite) `^2.3.0` |
| Path Utilities | [path](https://pub.dev/packages/path) `^1.8.3` |
| UI Design | Material 3 |

---

## 📁 Project Structure

```
lib/
├── main.dart                   # App entry point & theme configuration
├── screens/
│   ├── splash_screen.dart      # Animated splash / auth gate
│   ├── login_screen.dart       # User login UI
│   ├── signup_screen.dart      # User registration UI
│   └── home_screen.dart        # Main dashboard & transaction list
├── providers/
│   ├── auth_provider.dart      # Authentication state & logic (Riverpod)
│   ├── dashboard_provider.dart # VAT summary & transaction data (Riverpod)
│   └── splash_provider.dart    # Splash navigation logic
└── services/
    └── database_service.dart   # SQLite singleton — users & data persistence
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.10.7`
- Dart `>=3.0.0`
- Android Studio / VS Code with Flutter & Dart plugins
- An Android or iOS device / emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Safuvan988/taxxon.git
   cd taxxon
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Default Credentials

The app seeds a default user on first launch:

| Field | Value |
|---|---|
| Username | `user@123` |
| Password | `password123` |

> You can also create a new account via the **Sign Up** screen.

---

## 🏗️ Building for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (recommended for Play Store)
flutter build appbundle --release

# iOS (macOS only)
flutter build ios --release
```

---

## 🗺️ Roadmap

- [ ] Connect to live VAT/ERP APIs
- [ ] Add purchase & sales entry forms
- [ ] Export reports as PDF / Excel
- [ ] Multi-company / multi-user support
- [ ] Push notifications for VAT due dates
- [ ] Dark mode support
- [ ] Localization (Arabic / English)

---

## 🤝 Contributing

Contributions are welcome! Please open an issue to discuss proposed changes before submitting a pull request.

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'feat: add your feature'`
4. Push to branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📄 License

This project is proprietary software owned by **Syfton Innovations**. All rights reserved.

---

<p align="center">Built with ❤️ using Flutter</p>
