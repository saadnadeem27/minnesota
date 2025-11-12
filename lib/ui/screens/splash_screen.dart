import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Navigate after small delay
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(Routes.home);
    });

    final size = MediaQuery.of(context).size;
    final logoSize = size.width * 0.46;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo container similar to Figma large centered logo
              Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
