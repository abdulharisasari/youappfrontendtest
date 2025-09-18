# YouApp Frontend Test (Flutter + GetX)

This repository was created as part of the **Frontend Developer Test at
YouApp**.\
The project is built using **Flutter** with **GetX** state management
along with several supporting packages.

------------------------------------------------------------------------

## 🚀 Tech Stack

-   **Flutter 3.2.3+**
-   **GetX 4.6.6** → State management & routing
-   **GetStorage 2.1.1** → Lightweight local storage
-   **Dio 5.9.0** / **http 1.2.0** → API client
-   **Shared Preferences 2.2.3** → Persistent storage
-   **Image Picker 1.0.0** → Image upload

------------------------------------------------------------------------

## ⚙️ Getting Started

### 1. Clone repository

``` bash
git clone https://github.com/abdulharisasari/youappfrontendtest.git
cd youappfrontendtest
```

### 2. Install dependencies

``` bash
flutter pub get
```

### 3. Run the app

``` bash
flutter run
```

------------------------------------------------------------------------

## 📂 Project Structure

    lib/
    ├── core/                  # Konstanta & utilitas global
    │   ├── assets.dart
    │   ├── themes.dart
    │   └── utils.dart
    │
    ├── data/                  # Data layer (models, repository, API)
    │   ├── models/
    │   │   ├── auth_model.dart
    │   │   ├── profile_model.dart
    │   │   └── response_api.dart
    │   ├── providers/         # API providers (Dio/HTTP)
    │   └── repository/
    │       └── user_repository.dart
    │
    ├── modules/               # Feature-based modules
    │   ├── home/
    │   │   ├── bindings/
    │   │   ├── controllers/
    │   │   └── views/
    │   ├── login/
    │   │   ├── bindings/
    │   │   ├── controllers/
    │   │   └── views/
    │   ├── register/
    │   │   ├── bindings/
    │   │   ├── controllers/
    │   │   └── views/
    │   └── profile/
    │       ├── bindings/
    │       ├── controllers/
    │       └── views/
    │
    ├── routes/                # App routing
    │   ├── app_pages.dart
    │   └── app_routes.dart
    │
    ├── widgets/               # Reusable widgets/components
    │   └── custom_button.dart
    │   └── custom_input.dart
    │
    └── main.dart              # Entry point
        

------------------------------------------------------------------------

## ✨ Features Implemented

- [x] Authentication  
  - Login  
  - Register  
  - Logout (with GetX)

- [x] Profile Management  
  - View profile  
  - Create & Update profile (name, bio, birth date, zodiac, horoscope, profile picture)

- [x] Horoscope  
  - Display Western Horoscope based on birth date

- [x] Chinese Zodiac  
  - Display Chinese Zodiac based on birth year

- [x] Data Storage  
  - Local storage using GetStorage  
  - Persistent storage using SharedPreferences

- [x] Image Upload  
  - Upload profile picture using Image Picker

- [ ] (Optional) Extra Features  
  - e.g. Dark Mode, Notifications, Profile Editing enhancements

------------------------------------------------------------------------

## 📸 Screenshots

> Add some screenshots of the app so reviewers can quickly see the
> results without running it.

------------------------------------------------------------------------

## 📧 Contact

-   Name: **Abdul Haris Asari**
-   Email: **abdulharisasari@gmail.com**
-   YouApp Profile: **youapp.me/abdulharisasari**

------------------------------------------------------------------------

✨ Thank you to the **YouApp** team for this opportunity.\
I hope this project demonstrates my ability to build Flutter
applications using **GetX**.
