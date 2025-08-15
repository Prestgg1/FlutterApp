import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessfullRezervation extends StatelessWidget {
  const SuccessfullRezervation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 51),

                      Text(
                        'Rezervasiyanız uğurla\nbaşa çatdı!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF226C63),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          height: 1.1,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          color: const Color(0xFF226C63),
                          borderRadius: BorderRadius.circular(105),
                        ),
                        child: Center(
                          child: Image.network(
                            'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F7852c741-8861-4cbb-8650-60459823154d.png',
                            width: 28,
                            height: 21,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Detallar başlığı
                      Text(
                        'Detallar',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF474A56),
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Rezervasiya nömrəsi
                      Text(
                        'Rezervasiya nömrəniz: 856345',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF474A56),
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Alt bölmə - xətt, başlıq və info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F2e1561b7-fc42-4047-9910-9cf292ba8bdd.png',
                            width: 354,
                            height: 1,
                            fit: BoxFit.contain,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'CASH\nXƏSTƏXANA ÖDƏIŞI',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF8A8A8A),
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 40),

                          Text(
                            '100 AZN',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF474A56),
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 40),

                          Text(
                            'PAYMENT DATE',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF8A8A8A),
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            '13 Jul, 11:17',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF474A56),
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 30),

                          Text(
                            'HƏKIM',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF8A8A8A),
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            '13 Jul, 11:17',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF474A56),
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Əsas səhifəyə qayıt düyməsi
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF226C63),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                context.go('/');
                              },
                              child: Text(
                                'Əsas səhifəyə qayıt',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
