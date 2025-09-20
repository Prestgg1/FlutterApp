import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safatapp/components/OtpInputSection.dart';

// Ana Sayfa Stateless
class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                  'Mailinizi yoxlayın',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF1E1E1E),
                    fontSize: 18,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 10),

                // Açıklama
                Text(
                  'We sent a reset link to alpha...@gmail.com\nenter 5 digit code that mentioned in the email',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF989898),
                    fontSize: 14,
                    height: 1.7,
                  ),
                ),

                const SizedBox(height: 30),

                // Ayrılmış Stateful Widget: Input ve Buton
                OtpInputSection(email: email),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
