# PollDAO — Flutter Mobile Application

> A polling and voting platform where users can participate in topic-based polls and track results in real time.

---

## 📱 About

**PollDAO** is a Flutter mobile application that allows users to register, discover topics, participate in active polls, and view results. The app is built on a **Clean Architecture (Feature-first)** structure.

---

## 🏗️ Architecture

The project follows **Feature-first Clean Architecture**:

```
lib/
├── main.dart                  # Entry point — Provider + BLoC setup
└── src/
    ├── config/
    │   ├── routes/            # Routing (AppRoutes, RouteNames)
    │   └── theme/             # App theme
    ├── core/
    │   ├── colors/            # Color constants
    │   ├── constants/         # Server & general constants
    │   ├── extensions/        # Dart extensions
    │   ├── icons/             # Icons
    │   ├── singleton/         # Singleton patterns
    │   └── size/              # Screen size utilities
    └── features/
        ├── splash_page/
        ├── onboarding_page/
        ├── sign_in_page/
        ├── sign_up_page/
        ├── discover_page/
        ├── active_polls_page/
        ├── poll_result_page/
        ├── profile_page/
        ├── topics/
        ├── create_poll/
        ├── language_page/
        ├── location_page/
        ├── nationality_page/
        ├── education_level_page/
        ├── image_select/
        ├── local_auth/
        └── widget_servers/
```

Each feature is divided into layers:

| Layer          | Responsibility                                  |
|----------------|-------------------------------------------------|
| `data/`        | Repository implementations, API calls           |
| `domain/`      | Repository interfaces, models                   |
| `logic/`       | BLoC / ChangeNotifier (state management)        |
| `presentation/`| Pages and widgets                               |

---

## 🗺️ Routing

Centralized routing via `onGenerateRoute`:

| Route                     | Page                    |
|---------------------------|-------------------------|
| `/`                       | Splash Page             |
| `/active_pols_page`       | Active Polls Page       |
| `/discover_page`          | Discover Page           |
| `/onboarding_page`        | Onboarding Page         |
| `/poll_result_page`       | Poll Result Page        |
| `profile_page`            | Profile Page            |
| `sign_in_page`            | Sign In Page            |
| `sign_up_page`            | Sign Up Page            |
| `nationality_page`        | Nationality Page        |
| `language_page`           | Language Page           |
| `location_page`           | Location Page           |
| `education_language_page` | Education Level Page    |

---

## 🌐 API & Networking

- **Base URL:** `http://94.131.10.253:3000`
- **HTTP Client:** Dio with request/response/error interceptors
- **Auth:** Token stored via `SharedPreferences`

| Timeout Type    | Constant                          |
|-----------------|-----------------------------------|
| Connect timeout | `TimeOutConstants.connectTimeout` |
| Receive timeout | `TimeOutConstants.receiveTimeout` |
| Send timeout    | `TimeOutConstants.sendTimeout`    |

---

## 🧠 State Management

| Technology     | Usage                                                     |
|----------------|-----------------------------------------------------------|
| `flutter_bloc` | Profile data loading (`FetchProfileDataBloc`)             |
| `provider`     | Topics (`TopicNotifier`), Categories (`CategoryProvider`) |

---

## 📦 Key Dependencies

| Package                       | Version     | Purpose                        |
|-------------------------------|-------------|--------------------------------|
| `flutter_bloc`                | ^8.1.5      | BLoC state management          |
| `provider`                    | ^6.1.2      | ChangeNotifier state management|
| `dio`                         | ^5.4.3+1    | HTTP networking                |
| `shared_preferences`          | ^2.2.3      | Local data storage             |
| `local_auth`                  | ^2.2.0      | Biometric authentication       |
| `image_picker`                | ^1.0.8      | Camera / gallery access        |
| `flutter_svg`                 | ^2.0.10+1   | SVG rendering                  |
| `permission_handler`          | ^11.3.1     | Runtime permissions            |
| `equatable`                   | ^2.0.5      | Value equality                 |
| `logger`                      | ^2.2.0      | Logging                        |
| `card_swiper`                 | ^3.0.1      | Swipeable card UI              |
| `zoom_tap_animation`          | ^1.1.0      | Tap animation                  |
| `auto_size_text`              | ^3.0.0      | Auto-scaling text              |
| `flutter_staggered_grid_view` | ^0.7.0      | Staggered grid layout          |

---

## 🎨 Design

- **Font:** SF Pro (OTF, all weights included)
- **Icons:** SVG format (`assets/svg/`)
- **Images:** PNG/JPG format (`assets/images/`)
- **Orientation:** Portrait only (`portraitUp`)
- **UI Framework:** Material 3

---

## 🚀 Getting Started

### Requirements

- Flutter SDK `>=3.3.1 <4.0.0`
- Dart SDK

### Setup

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Build release APK
flutter build apk --release
```

---

## 📋 Project Status

- [x] Splash & Onboarding screens
- [x] Sign In / Sign Up (authentication)
- [x] Profile page
- [x] Discover topics
- [x] Active polls
- [x] Poll results
- [x] Language / Location / Nationality / Education settings
- [x] Biometric login (local_auth)
- [ ] Create Poll — in progress
