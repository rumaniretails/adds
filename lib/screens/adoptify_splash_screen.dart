import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:templering/screens/home.dart';
import 'package:templering/screens/userinfo.dart';
import 'package:templering/utils/adoptify_loader.dart';
import '../utils/color.dart';

class AdoptifySplashscreen extends StatelessWidget {
  const AdoptifySplashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      bool isUserRegistered = prefs.getBool("isRegistered") ?? false;

      if (isUserRegistered) {
        Get.off(() => const HomeScreen());
      } else {
        Get.off(() => const UserInfoFormScreen());
      }
    });

    return Scaffold(
      backgroundColor: adoptifyPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            200.height,
            Image.asset(
              "images/app/bell.png",
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            30.height,
            const Text(
              'Temple Ring',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w600,
                // ignore: deprecated_member_use
              ),
            ).paddingBottom(MediaQuery.of(context).size.height * 0.2),
            LoaderWidget(color: white)
          ],
        ),
      ),
    );
  }
}
