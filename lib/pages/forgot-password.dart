import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
                  top: 198,
                  child: Text(
                    'Email',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: const Color(0xFF2A2A2A),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ),
                Positioned(
                  left: 9,
                  top: 150,
                  child: Text(
                    'Mailinizi daxil edin və şifrənizi yeniləyin',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: const Color(0xFF989898),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                Positioned(
                  left: 9,
                  top: 114,
                  child: Text(
                    'Şifrənizi unutmusuz',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: const Color(0xFF1E1E1E),
                      fontSize: 18,
                      height: 1.1,
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 226,
                  child: Container(
                    width: 341,
                    height: 51,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE1E1E1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email daxil edin',
                          hintStyle: TextStyle(
                            color: Color(0xFFB3B3B3),
                            fontSize: 14,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 300,
                  child: GestureDetector(
                    onTap: () {
                      // Butona basıldığında yapılacak işlemler buraya
                      context.push("/otp");
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
                        'Dəvam et',
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
                        'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F13d57a91-8644-44ea-923b-2a6d9b64ba8f.png',
                        width: 8,
                        height: 18,
                        fit: BoxFit.contain,
                      ),
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
