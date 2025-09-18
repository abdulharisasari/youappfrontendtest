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
     ├── main.dart                # Entry point
     ├── app/
     │   ├── bindings/            # Dependency injection with GetX
     │   ├── controllers/         # GetX controllers (logic)
     │   ├── data/                # API services, models
     │   ├── routes/              # Application routes
     │   ├── ui/                  # Views & widgets
     │   └── utils/               # Helper functions
    assets/
     ├── images/                  # PNG/JPG images
     └── svg/                     # SVG icons

------------------------------------------------------------------------

## ✨ Features Implemented

-   [x] Authentication (Login / Register / Logout with GetX)
-   [x] Display **Horoscope** based on birth date
-   [x] Display **Chinese Zodiac** based on birth year
-   [x] Data storage using **GetStorage** & **SharedPreferences**
-   [x] Image upload with **Image Picker**
-   [ ] (Optional) Extra features

------------------------------------------------------------------------

## 📸 Screenshots

> Add some screenshots of the app so reviewers can quickly see the
> results without running it.

------------------------------------------------------------------------

## 📧 Contact

-   Name: **Abdul Haris Asari**\
-   Email: **\[abdulharisasari@gmail.com\]**\
-   YouApp Profile: **\[youapp.me/abdulharisasari\]**

------------------------------------------------------------------------

✨ Thank you to the **YouApp** team for this opportunity.\
I hope this project demonstrates my ability to build Flutter
applications using **GetX**.
