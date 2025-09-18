import 'package:get/get.dart';
import '../../../core/utils.dart';
import '../../../data/providers/api_provider.dart';
import '../../../data/repository/user_repository.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/models/response_api.dart';
import '../../../routes/constant_route.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var token = "".obs;

  late final UserRepository _repo;

  @override
  void onInit() {
    super.onInit();
    _repo = UserRepository(ApiProvider());
  }

  Future<void> login(AuthRequest request) async {
    try {
      isLoading.value = true;
      final ResponseApi response = await _repo.login(request);
      if (response.code == 201 && response.message != 'User not found' && response.accessToken != null) {
        Utils.saveToken(response.accessToken!);
        Get.snackbar("Success", response.message);
        Get.toNamed(profileRoute);
        print("TOKEN: ${response.accessToken}");

      } else if(response.accessToken == null){
        Get.snackbar("Error", "Token ismpty");

      } else if (response.message == 'User not found'){
        Get.snackbar("Error", response.message);

      } else {
        Get.snackbar("Error", "Unexpected code: ${response.code}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
