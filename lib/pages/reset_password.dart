import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  // Buraya istersen TextEditingController ve diğer state yönetimi ekleyebilirsin

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
                  top: 208,
                  child: Text(
                    'Parol',
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
                    'Yeni parol yaradın. fərqli olduğundan əmin olun\r\ntəhlükəsizlik üçün əvvəlkilər',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: const Color(0xFF989898),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Positioned(
                  left: 9,
                  top: 114,
                  child: Text(
                    'Yeni parol təyin edin',
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
                  top: 236,
                  child: Container(
                    width: 341,
                    height: 51,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE1E1E1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // Buraya TextField veya başka widget eklenebilir
                  ),
                ),
                Positioned(
                  left: 318,
                  top: 252,
                  child: Container(
                    width: 19,
                    height: 19,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: 1,
                          child: Image.network(
                            'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F131f1991-2767-457e-9010-4280ba811f2e.png',
                            width: 19,
                            height: 18,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Noktalar (parola güvenlik göstergesi gibi)
                for (int i = 0; i < 11; i++)
                  Positioned(
                    left: 25.0 + (11 * i),
                    top: 259,
                    child: Container(
                      width: 6,
                      height: 6,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFF545454),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                Positioned(
                  left: 10,
                  top: 410,
                  child: GestureDetector(
                    onTap: () {
                      // Buton tıklama olayı
                      debugPrint('Parolu yenilə butonuna basıldı');
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
                        'Parolu yeniləyin',
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
                  ),
                ),
                Positioned(
                  left: 26,
                  top: 61,
                  child: Image.network(
                    'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2Fbb416e60-3725-41c2-87ff-6d7c1c9e5ed6.png',
                    width: 8,
                    height: 18,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: 9,
                  top: 303,
                  child: Text(
                    'Şifrəni təsdiqləyin',
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
                  left: 10,
                  top: 331,
                  child: Container(
                    width: 341,
                    height: 51,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE1E1E1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // Buraya TextField eklenebilir
                  ),
                ),
                Positioned(
                  left: 318,
                  top: 347,
                  child: Container(
                    width: 19,
                    height: 19,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: 1,
                          child: Image.network(
                            'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F3afa318e-b7b0-4957-99c4-5c49d4dc52a4.png',
                            width: 19,
                            height: 18,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // İkinci güvenlik noktaları
                for (int i = 0; i < 11; i++)
                  Positioned(
                    left: 25.0 + (11 * i),
                    top: 354,
                    child: Container(
                      width: 6,
                      height: 6,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFF545454),
                        borderRadius: BorderRadius.circular(3),
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
