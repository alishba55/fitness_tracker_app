<div align="center">

<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
<img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
<img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" />
<img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blue?style=for-the-badge" />

# 🏋️ FitTrack

### *Track your fitness journey — every step, every day.*

**FitTrack** is a powerful and user-friendly Flutter fitness app that helps you manage your daily fitness activities, goals, and progress all in one place.

</div>

---

## 📸 Screenshots

| Home Dashboard | Workout List | Progress Charts | BMI Calculator |
|:-:|:-:|:-:|:-:|
| 🏠 | 💪 | 📊 | ⚖️ |

> *(Screenshots coming soon)*

---

## ✨ Features

### 🏃 Activity Tracking
- **Step Tracker** — Count your daily steps and hit your goals
- **Water Intake Tracker** — Stay on top of your hydration
- **Calories Tracker** — Monitor your calorie intake and burn

### 💪 Workout Management
- **Workout List** — Browse and discover your workouts
- **Workout Detail Screen** — View complete details for every exercise

### 📊 Progress & Analytics
- **Progress Charts** — Beautiful interactive graphs powered by `fl_chart`
- **Weight Progress Tracker** — Visualize your weight loss / gain journey
- **BMI Calculator** — Calculate and monitor your Body Mass Index

### 👤 Profile & Settings
- **Profile Screen** — Manage your personal information
- **Edit Profile** — Update your profile anytime
- **Settings Screen** — Customize the app to your preferences

### 🌙 Extras
- **Splash Screen** — Smooth and professional app launch
- **Dark Mode Support** — Eye-friendly dark theme
- **Local Storage** — Data saved securely with `SharedPreferences`

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| **Flutter** | Cross-platform UI framework |
| **Dart** | Programming language |
| **SharedPreferences** | Local data persistence |
| **fl_chart** | Charts & data visualization |

---

## 📱 App Screens

```
FitTrack
├── 🏠  Home         →  Dashboard with daily summary
├── 💪  Workout      →  Workout list & details
├── 📋  Tracker      →  Water, calories & steps
├── 📊  Progress     →  Charts & weight tracking
├── 👤  Profile      →  User info & BMI calculator
└── ⚙️  Settings     →  App preferences & dark mode
```

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0 or above)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio or VS Code
- Android Emulator or a physical device

### Installation

**1. Clone the repository:**
```bash
git clone your-repository-link
cd fittrack
```

**2. Install dependencies:**
```bash
flutter pub get
```

**3. Run the app:**
```bash
flutter run
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# iOS (requires macOS)
flutter build ios --release
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.0
  fl_chart: ^0.65.0
```

---

## 📁 Project Structure

```
lib/
├── main.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── workout/
│   │   ├── workout_list.dart
│   │   └── workout_detail.dart
│   ├── tracker/
│   │   ├── water_tracker.dart
│   │   ├── calories_tracker.dart
│   │   └── step_tracker.dart
│   ├── progress/
│   │   ├── progress_charts.dart
│   │   └── weight_tracker.dart
│   ├── profile/
│   │   ├── profile_screen.dart
│   │   └── edit_profile.dart
│   └── settings/
│       └── settings_screen.dart
├── models/
├── widgets/
└── utils/
```

---

## 🤝 Contributing

Contributions are welcome! If you'd like to improve this project:

1. **Fork** the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a **Pull Request**

---

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Developer

**Your Name**
📧 alishbakanwal101@gmail.com
🔗 [GitHub](https://github.com/alishba55)

---

<div align="center">

⭐ **If you found this project helpful, please give it a star!** ⭐

*Made with ❤️ using Flutter*

</div>
