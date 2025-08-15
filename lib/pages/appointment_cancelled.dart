import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentCancelled extends StatelessWidget {
  const AppointmentCancelled({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Yeşil daire ve ikon
              Container(
                width: screenWidth * 0.3,
                height: screenWidth * 0.3,
                decoration: BoxDecoration(
                  color: const Color(0xFF226C63),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.network(
                    'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2Fd7c39ea1-1449-4ac3-bf67-bae11a5c9926.png',
                    width: screenWidth * 0.12,
                    height: screenWidth * 0.12,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Metin
              Text(
                'Rezervasiyanız ləğv olundu.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF226C63),
                  fontSize: screenWidth * 0.07, // responsive font
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
