import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  Widget buildTextField(String label, String value, {bool isDropdown = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFF232323),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.9, color: const Color(0x66208971)),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF226C63),
                  fontSize: 13,
                ),
              ),
              if (isDropdown)
                Image.network(
                  'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F0bbf27f4-4930-4524-a36e-1046389c00af.png',
                  width: 12,
                  height: 7,
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profil fotoğrafı
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0S4Cv9GzpkFeQFL3zg0b%2Ff72d6d0a1c497944680ae28816f56aea3123b126image%201.png?alt=media&token=3da4ff97-ce09-4cfc-936c-abd66860ee4a',
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF248C76),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2Ff4ecdf38-6c0c-4b83-821d-c09b80952c4e.png',
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Form alanları
              buildTextField("Ad/Soyad", "Fidan Haqverdiyeva"),
              const SizedBox(height: 16),
              buildTextField("Email", "fidanhaqverdiyeva299gmail.com"),
              const SizedBox(height: 16),
              buildTextField(
                "Doğum tarixi",
                "25 January 1990",
                isDropdown: true,
              ),
              const SizedBox(height: 16),
              buildTextField("Fin kod", "45962"),
              const SizedBox(height: 16),
              buildTextField("Şəhər", "San Jose, California, USA"),
              const SizedBox(height: 16),
              buildTextField("Rayon", "San Jose"),
              const SizedBox(height: 16),
              buildTextField("Küçə", "USA"),
              const SizedBox(height: 16),
              buildTextField("Mənzil", "San Jose, California, USA"),

              const SizedBox(height: 32),

              // Buton
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF226C63),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Yadda saxla",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
