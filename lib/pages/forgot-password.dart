import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safatapp/components/forget_password_form.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Geri butonu
              GestureDetector(
                onTap: () => {
                  context.pop()
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBEBEB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/back.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Başlık
              Text(
                'Şifrənizi unutmusuz',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF1E1E1E),
                  fontSize: 18,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),

              // Açıklama
              Text(
                'Mailinizi daxil edin və şifrənizi yeniləyin',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF989898),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),

              // Ayrı component olan form
              const ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
