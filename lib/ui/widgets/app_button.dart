import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppButtonStyle { primaryBlue, primaryGreen, neutral, dangerRed }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final AppButtonStyle style;
  final EdgeInsetsGeometry padding;

  const AppButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.style = AppButtonStyle.primaryBlue,
    this.padding = const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
  }) : super(key: key);

  BoxDecoration _decoration(AppButtonStyle s, BuildContext context) {
    switch (s) {
      case AppButtonStyle.primaryGreen:
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF39C02E), Color(0xFF28A71F)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1C8B15).withOpacity(0.24),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
            const BoxShadow(
              color: Colors.white30,
              offset: Offset(0, -2),
              blurRadius: 2,
            ),
          ],
        );

      case AppButtonStyle.neutral:
        return BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(0, -2),
              blurRadius: 2,
            ),
          ],
        );

      case AppButtonStyle.dangerRed:
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFEC584C), Color(0xFFD93C33)], // Red gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFB5342C).withOpacity(0.3),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
            const BoxShadow(
              color: Colors.white30,
              offset: Offset(0, -2),
              blurRadius: 2,
            ),
          ],
        );

      case AppButtonStyle.primaryBlue:
      default:
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1595CF), Color(0xFF0C78AC)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0A6EA0).withOpacity(0.24),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
            const BoxShadow(
              color: Colors.white30,
              offset: Offset(0, -2),
              blurRadius: 2,
            ),
          ],
        );
    }
  }

  Color _textColor(AppButtonStyle s) {
    return s == AppButtonStyle.neutral ? const Color(0xFF666666) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final decoration = _decoration(style, context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: decoration,
          padding: padding,
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.mulish(
              color: _textColor(style),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
