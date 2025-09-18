import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:get_storage/get_storage.dart';

import 'assets.dart';


class Utils {
  static final _box = GetStorage();
  static const _tokenKey = "ACCESS_TOKEN";
  static const String _profileImageKeyPrefix = "PROFILE_IMAGE_"; 
  static const String _profileGenderKeyPrefix = "PROFILE_GENDER_"; 
  
  static void saveToken(String token) {
    _box.write(_tokenKey, token);
  }

  static String? getToken() {
    return _box.read(_tokenKey);
  }

  static void clearToken() {
    _box.remove(_tokenKey);
  }


  static Options headerToken() {
    final token = getToken();
    return Options(
      headers: {
        "x-access-token": token ?? "",
        "Content-Type": "application/json",
      },
    );
  }


  static Future<File?> saveProfileImage(File imageFile, String profileId) async {
    try {
      final directory = await getApplicationDocumentsDirectory(); 
      final filePath = '${directory.path}/profile_$profileId.png';
      
      final savedImage = await imageFile.copy(filePath);
      
      _box.write('$_profileImageKeyPrefix$profileId', filePath);
      return savedImage;
    } catch (e) {
      print("Error saving profile image: $e");
      return null;
    }
  }

  static File? getProfileImage(String profileId) {
    final path = _box.read('$_profileImageKeyPrefix$profileId');
    if (path != null) {
      final file = File(path);
      if (file.existsSync()) {
        return file;
      }
    }
    return null;
  }

  static void clearProfileImage(String profileId) {
    final path = _box.read('$_profileImageKeyPrefix$profileId');
    if (path != null) {
      final file = File(path);
      if (file.existsSync()) {
        file.deleteSync();
      }
      _box.remove('$_profileImageKeyPrefix$profileId');
    }
  }

  static void saveProfileGender(String email, String gender) {
    final key = '$_profileGenderKeyPrefix${email.trim().toLowerCase()}';
    _box.write(key, gender);
  }

  static String? getProfileGender(String email) {
    final key = '$_profileGenderKeyPrefix${email.trim().toLowerCase()}';
    return _box.read(key);
  }

  static void clearProfileGender(String email) {
    final key = '$_profileGenderKeyPrefix${email.trim().toLowerCase()}';
    _box.remove(key);
  }

    
  static int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  static String getHoroscope(DateTime date) {
    final day = date.day;
    final month = date.month;

    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return "Aries";
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return "Taurus";
    if ((month == 5 && day >= 21) || (month == 6 && day <= 21)) return "Gemini";
    if ((month == 6 && day >= 22) || (month == 7 && day <= 22)) return "Cancer";
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return "Leo";
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return "Virgo";
    if ((month == 9 && day >= 23) || (month == 10 && day <= 23)) return "Libra";
    if ((month == 10 && day >= 24) || (month == 11 && day <= 21)) return "Scorpius";
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return "Sagittarius";
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return "Capricornus";
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return "Aquarius";
    if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) return "Pisces";
    return "--";
  }

  static String getHoroscopeAsset(String name) {
    switch (name) {
      case "Aries": return icHoroscopeAries;
      case "Taurus": return icHoroscopeTaurus;
      case "Gemini": return icHoroscopeGemini;
      case "Cancer": return icHoroscopeCancer;
      case "Leo": return icHoroscopeLeo;
      case "Virgo": return icHoroscopeVirgo;
      case "Libra": return icHoroscopeLibra;
      case "Scorpio":
      case "Scorpius": return icHoroscopeScorpio;
      case "Sagittarius": return icHoroscopeSagittarius;
      case "Capricorn":
      case "Capricornus": return icHoroscopeCapricorn;
      case "Aquarius": return icHoroscopeAquarius;
      case "Pisces": return icHoroscopePisces;
      default: return '';
    }
  }


  static String getZodiac(DateTime date) {
    int year = date.year;
    List<String> zodiacAnimals = ["Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake","Horse", "Goat", "Monkey", "Rooster", "Dog", "Pig"];
    int index = (year - 2008) % 12;
    if (index < 0) index += 12;

    return zodiacAnimals[index];
  }

  
    
  static String getZodiacAsset(String name) {
    switch (name) {
      case "Rat": return icZodiacRat;
      case "Ox":
      case "Cattle":
      case "Cow": return icZodiacOx;
      case "Tiger": return icZodiacTiger;
      case "Rabbit":
      case "Hare": return icZodiacRabbit;
      case "Dragon": return icZodiacDragon;
      case "Snake": return icZodiacSnake;
      case "Horse": return icZodiacHorse;
      case "Goat":
      case "Sheep": return icZodiacGoat;
      case "Monkey": return icZodiacMonkey;
      case "Rooster":
      case "Chicken": return icZodiacRooster;
      case "Dog": return icZodiacDog;
      case "Pig":
      case "Boar": return icZodiacPig;
      default: return '';
    }
  }
  
  static Future<void> showExitConfirmation(BuildContext context) async {
    bool? confirmExit = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmation"),
        content: Text("Are you sure you want to exit the app?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: Text("Exit"),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmExit == true) {
      SystemNavigator.pop(); 
      
    }
  }

  static Future<void> showLogoutConfirmation() async {
    bool? confirmLogout = await Get.dialog<bool>(
      AlertDialog(
        title: Text("Confirmation"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(
            child: Text("Logout"),
            onPressed: () => Get.back(result: true),
          ),
        ],
      ),
    );

    if (confirmLogout == true) {
      Utils.clearToken();
      Get.offAllNamed('/login');
    }
  }

}
