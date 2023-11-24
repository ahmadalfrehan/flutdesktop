import 'package:flutdesktop/config/extension.dart';
import 'package:flutdesktop/config/textStyle.dart';
import 'package:flutdesktop/presentation/auth/getx/auth-controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/style.dart';

class Login extends GetView<AuthController> {
  Login({Key? key}) : super(key: key);
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        elevation: 0,
      ),
      body: Container(
        color: CupertinoColors.lightBackgroundGray,
        child: Column(
          children: [
            Container(
              height: 40,
              width: Get.width / 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colorBlueLogo,
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://ahmadalfrehan.com/assets/assets/images/logo-05.png'),
                ),
              ),
            ),
            50.height,
            Center(
              child: SizedBox(
                width: Get.width / 2.2,
                height: Get.height / 1.6,
                child: Card(
                  color: colorWhite,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyleMyApp.textStyle2,
                        ),
                        10.height,
                        const Text(
                          "Enter your Email and password to access your account",
                          style: TextStyleMyApp.textStyle3,
                        ),
                        20.height,
                        textFormField(
                            controller.emailController,
                            "Enter your email",
                            const Icon(
                              Icons.email,
                              color: colorBlueLogo,
                            )),
                        30.height,
                        textFormField(
                            controller.passwordController,
                            "Enter your password",
                            const Icon(
                              Icons.password,
                              color: colorBlueLogo,
                            )),
                        50.height,
                        Obx(
                          () => controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    controller.isLogin.value
                                        ? controller.login(context)
                                        : controller.addUser();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: colorBlueLogo,
                                      fixedSize: Size(Get.width / 2, 60),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  child: Text(controller.isLogin.value
                                      ? "SIGN IN"
                                      : "SIGN UP"),
                                ),
                        ),
                        // 20.height,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            30.height,
            Obx(
              () => InkWell(
                onTap: () {
                  controller.isLogin.value = !controller.isLogin.value;
                },
                child: Text(
                    controller.isLogin.value
                        ? "Dont have an account, signup?"
                        : "You have an account,Login?",
                    style: const TextStyle(
                        color: colorBlueLogo,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline)),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const Text("Forgot Password?",
                  style: TextStyle(
                      color: colorBlueLogo,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline)),
            )
          ],
        ),
      ),
    );
  }

  textFormField(
      TextEditingController textEditingController, String hint, Icon icon) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: hint,
          prefixIcon: icon),
    );
  }
}
