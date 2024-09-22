import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/user_repository.dart/user_repository.dart';
import '../routes/routing_name.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  final UserRepository userRepository = UserRepository.instance;

  final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
    r"[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      isLoading.value = true;
      await userRepository.loginUser(email, password);
      Get.offNamed(RoutingNames.newsFeed);
    } catch (e) {
      Get.snackbar(
        "Login Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade500,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
