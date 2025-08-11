import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  // İstersen burada TextEditingController ve doğrulama ekleyebilirsin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 360,
          height: 800,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(color: Colors.white),
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 9,
                  top: 150,
                  child: SizedBox(
                    width: 342,
                    child: Text(
                      'We sent a reset link to alpha...@gmail.com\nenter 5 digit code that mentioned in the email',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: const Color(0xFF989898),
                        fontSize: 14,
                        height: 1.7,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 9,
                  top: 114,
                  child: Text(
                    'Mailinizi yoxlayın',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: const Color(0xFF1E1E1E),
                      fontSize: 18,
                      height: 1.1,
                    ),
                  ),
                ),
                // OTP Kod kutuları
                for (var i = 0; i < 5; i++)
                  Positioned(
                    left: 24.0 + (66 * i),
                    top: 226,
                    child: Container(
                      width: 51,
                      height: 51,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE1E1E1)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 10,
                  top: 300,
                  child: GestureDetector(
                    onTap: () {
                      // Butona basılınca yapılacak işlemler
                      context.push("/reset-password");
                    },
                    child: Container(
                      width: 340,
                      height: 50,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFF226C63),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Kodu doğrulayın',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 50,
                  child: Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBEBEB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F1da66731-d6b6-48bd-b902-9d54cedbe51a.png',
                        width: 8,
                        height: 18,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 38,
                  top: 369,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: const Color(0xFF989898),
                        fontSize: 14,
                      ),
                      children: const [
                        TextSpan(text: 'Haven’t got the email yet?'),
                        TextSpan(
                          text: ' ',
                          style: TextStyle(color: Color(0xFF2A2A2A)),
                        ),
                        TextSpan(
                          text: 'Resend email',
                          style: TextStyle(
                            color: Color(0xFF648DDB),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
