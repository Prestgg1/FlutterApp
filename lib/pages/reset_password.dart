import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safatapp/components/reset_password_form.dart';
import 'package:go_router/go_router.dart';

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Geri butonu
            Positioned(
              left: 10,
              top: 10,
              child:  GestureDetector(
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
            ),

            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yeni parol təyin edin',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF1E1E1E),
                        fontSize: 18,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Yeni parol yaradın. fərqli olduğundan əmin olun\ntəhlükəsizlik üçün əvvəlkilər',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF989898),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Form hissəsi
                    PasswordResetForm(email: email, otp: otp),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
