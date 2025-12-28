import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../ui/widgets/app_button.dart';
import '../../routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _subtitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Improve your focus and eye coordination, one session at a time.',
        textAlign: TextAlign.center,
        style: GoogleFonts.mulish(fontSize: 18, color: Color(0xFF6C6C6C),fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final logoHeight = size.height * 0.22;
    final spacing = 20.0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // logo + title
                  SizedBox(
                    height: logoHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/logo.png', width: logoHeight * 1, height: logoHeight * 0.7, fit: BoxFit.contain),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  _subtitle(),
                  SizedBox(height: spacing * 2),

                  // Buttons (Start Session, Settings, Help)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        // ✅ Start Session (Blue)
                        SizedBox(
                          width: double.infinity,
                          child: AppButton(
                            label: 'Start Session',
                            style: AppButtonStyle.primaryBlue,
                            onTap: () => Get.toNamed(Routes.gridSetup),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                          ),
                        ),
                        // const SizedBox(height: 18),
                        // // ✅ Settings (Green)
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: AppButton(
                        //     label: 'Settings',
                        //     style: AppButtonStyle.primaryGreen,
                        //     onTap: () => Get.toNamed(Routes.settings),
                        //     padding: const EdgeInsets.symmetric(vertical: 18),
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),
                   Text(
                    'Designed for visual therapy and relaxation.',
                    style: GoogleFonts.mulish(fontSize: 14, color: Color(0xFF6C6C6C),fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
