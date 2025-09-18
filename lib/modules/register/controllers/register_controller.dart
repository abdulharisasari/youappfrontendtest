import 'package:get/get.dart';
import 'package:youappgetxtest/data/models/auth_model.dart';
import '../../../data/repository/user_repository.dart';
import '../../../routes/constant_route.dart';

class RegisterController extends GetxController {
  final UserRepository repository;
  RegisterController(this.repository);

  var isLoading = false.obs;

  Future<void> register(AuthRequest request) async {
    try {
      isLoading.value = true;
      final response = await repository.register(request);
      Get.snackbar("Success", response.message);
      Get.toNamed(loginRoute);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
