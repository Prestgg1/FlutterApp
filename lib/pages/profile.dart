import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:safatapp/services/api.dart';
import 'package:openapi/openapi.dart' as backend;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  backend.Profile? user;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final api = ApiService().api;
      final response = await api.getUserApi().getProfileApiUserProfileGet();
      ProfileCache.profile = response.data;

      setState(() {
        user = response.data;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF248C76)),
      );
    }

    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 30),

            ClipOval(
              child: Image.network(
                user?.user.image ?? '',
                width: 130,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _profileItem("Ad/Soyad", user?.user.name ?? ""),
                  _profileItem("Email", user?.user.email ?? ""),
                  _profileItem(
                    "Doğum tarixi",
                    user?.details.birthday.toString() ?? "",
                  ),
                  _profileItem("Fin kod", user?.details.finCode ?? ""),
                  _profileItem("Şəhər", user?.details.city ?? ""),
                  _profileItem("Rayon", user?.details.region ?? ""),
                  _profileItem("Küçə", user?.details.street ?? ""),
                  _profileItem("Address", user?.details.address ?? ""),
                ],
              ),
            ),
          ],
        ),

        // Sağ aşağıda buton
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF248C76),
            onPressed: () => context.go('/profile-edit'),
            child: const Icon(Icons.edit, color: Colors.white),
          ),
        ),
      ],
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
