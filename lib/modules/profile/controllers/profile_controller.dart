import 'package:get/get.dart';
import '../../../data/models/profile_model.dart';
import '../../../data/models/response_api.dart';
import '../../../data/repository/user_repository.dart';

class ProfileController extends GetxController {
  final UserRepository userRepository;
  ProfileController({required this.userRepository});

  var isLoading = false.obs;
  var message = "".obs;
   var profile = Rx<ProfileResponse?>(null);

  Future<bool> createProfile(ProfileRequest request) async {
    try {
      isLoading.value = true;
      final ResponseApi res = await userRepository.createProfile(request);
      message.value = res.message;
      return res.code == 201;
    } catch (e) {
      message.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }


  
  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      final result = await userRepository.getProfile();
      profile.value = result; 
      message.value = result.message ?? "No message";
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


  Future<bool> updateProfile(ProfileRequest request) async {
    try {
      isLoading.value = true;
      final ResponseApi res = await userRepository.updateProfile(request);
      message.value = res.message;
      
      await getProfile();

      return res.code == 200; 
    } catch (e) {
      message.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

