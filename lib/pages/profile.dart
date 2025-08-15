import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Üst logo ve düzenleme butonu
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      minimumSize: const Size(24, 24),
                      backgroundColor: const Color(0xFF248C76),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Icon(Icons.edit, size: 16, color: Colors.white),
                    onPressed: () {
                      context.go('/profile-edit');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Kullanıcı bilgileri
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _profileItem("Ad/Soyad", "Fidan Haqverdiyeva"),
                  _profileItem("Email", "fidanhaqverdiyeva299gmail.com"),
                  _profileItem("Doğum tarixi", "25 January 1990"),
                  _profileItem("Fin kod", "45962"),
                  _profileItem("Şəhər", "San Jose, California, USA"),
                  _profileItem("Rayon", "San Jose"),
                  _profileItem("Küçə", "USA"),
                  _profileItem("Mənzil", "San Jose, California, USA"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileItem(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: const Color(0x66208971), width: 0.9),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF232323),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF226C63),
            ),
          ),
        ],
      ),
    );
  }
}
