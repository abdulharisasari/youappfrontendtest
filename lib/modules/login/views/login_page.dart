import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youappgetxtest/core/utils.dart';
import 'package:youappgetxtest/routes/constant_route.dart';
import 'package:youappgetxtest/widgets/custom_back_button.dart';
import 'package:youappgetxtest/widgets/custom_background.dart';
import '../../../widgets/custom_button copy.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/gradient_text.dart';
import '../controllers/login_controller.dart';
import '../../../data/models/auth_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.find<LoginController>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();





  void _onLogin() {
    final request = AuthRequest(password: passwordController.text);
    final input = usernameController.text.trim();
    if (input.contains('@')) {
      request.email = usernameController.text;
      request.username = "";
    } else {
      request.email = "";
      request.username = usernameController.text;
    }
    controller.login(request);
  }



  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    usernameFocus.dispose();
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
                SizedBox(height: 50),
                CustomBackButtonRow(onTap: (){Utils.showExitConfirmation(context);}),
                SizedBox(height: 100),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text("Login",style: TextStyle( fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white) ),
                      ],
                    ),
                  ],
                ),
                CustomTextField( hintText: "Enter Username/Email", controller: usernameController, focusNode: usernameFocus ),
                CustomTextField( hintText: "Enter Password", controller: passwordController, focusNode: passwordFocus, isPassword: true),
                CustomButton(text: "Login",onTap: _onLogin),
                SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No account? ",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500)),
                    InkWell(
                      onTap: () => Get.toNamed(registerRoute),
                      child: GradientText("Register here", style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500)))
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