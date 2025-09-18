import 'package:get/get.dart';

import '../../../data/providers/api_provider.dart';
import '../../../data/repository/user_repository.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<UserRepository>(() => UserRepository(Get.find<ApiProvider>()));
    Get.lazyPut<ProfileController>(() => ProfileController(userRepository: Get.find<UserRepository>()));
  }
}