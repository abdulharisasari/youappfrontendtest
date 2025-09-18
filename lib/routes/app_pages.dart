import 'package:get/get.dart';
import 'package:youappgetxtest/modules/profile/binding/profile_binding.dart';
import 'package:youappgetxtest/modules/profile/views/profile_page.dart';
import 'package:youappgetxtest/modules/register/binding/register_binding.dart';
import 'package:youappgetxtest/modules/register/views/register_page.dart';
import '../modules/home/binding/home_binding.dart';
import '../modules/login/binding/login_binding.dart';
import '../modules/login/views/login_page.dart';
import '../modules/home/views/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER, 
      page: () => const RegisterPage(),
      binding: RegisterBinding()
    ),
    GetPage(
      name: Routes.PROFILE, 
      page: ()=> const ProfilePage(),
      binding: ProfileBinding()
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
