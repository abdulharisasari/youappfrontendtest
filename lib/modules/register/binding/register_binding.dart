import 'package:get/get.dart';
import '../../../data/providers/api_provider.dart';
import '../../../data/repository/user_repository.dart';
import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => UserRepository(Get.find()));
    Get.lazyPut(() => RegisterController(Get.find()));
  }
}
