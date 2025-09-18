import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youappgetxtest/data/models/auth_model.dart';
import 'package:youappgetxtest/widgets/custom_textfield.dart';
import '../../../routes/constant_route.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_background.dart';
import '../../../widgets/gradient_text.dart';
import '../controllers/register_controller.dart';
import '../../../widgets/custom_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Get.find<RegisterController>();

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailFN = FocusNode();
  final usernameFN = FocusNode();
  final passwordFN = FocusNode();
  final confirmPasswordFN = FocusNode();
  




  void _onRegister() {
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      Get.snackbar("Error", "Password and Confirm Password do not match");
      return;
    }
    final request = AuthRequest(
      email: emailController.text.trim(),
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
    );
    controller.register(request);
  }




  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFN.dispose();
    usernameFN.dispose();
    passwordFN.dispose();
    confirmPasswordFN.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButtonRow(onTap: (){Get.back();  print("back tapped! register");}),
                SizedBox(height: 100),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text("Register",style: TextStyle( fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white) ),
                      ],
                    ),
                  ],
                ),
                CustomTextField( hintText: "Enter Email", controller: emailController, focusNode: emailFN ),
                CustomTextField( hintText: "Create Username", controller: usernameController, focusNode: usernameFN ),
                CustomTextField( hintText: "Create Password", controller: passwordController, focusNode: passwordFN, isPassword: true),
                CustomTextField( hintText: "Confirm Password", controller: confirmPasswordController, focusNode: confirmPasswordFN, isPassword: true),
                CustomButton(text: "Register",onTap: _onRegister),
                SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account? ",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500)),
                    InkWell(
                      onTap: () => Get.toNamed(loginRoute),
                      child: GradientText("Login here", style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}