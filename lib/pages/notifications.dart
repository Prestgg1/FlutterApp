import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _buildNotificationItem(
            iconUrl:
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F483e485e-2846-4ab1-8077-755d5971d455.png',
            title: 'Kuryer gəldi',
            time: 'Last Wednesday at 9:42 AM',
          ),
          _buildNotificationItem(
            iconUrl:
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F483e485e-2846-4ab1-8077-755d5971d455.png',
            title: 'Kuryer gəldi',
            time: 'Last Wednesday at 9:42 AM',
          ),
          _buildNotificationItem(
            iconUrl:
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F483e485e-2846-4ab1-8077-755d5971d455.png',
            title: 'Kuryer gəldi',
            time: 'Last Wednesday at 9:42 AM',
          ),
          _buildNotificationItem(
            iconUrl:
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F483e485e-2846-4ab1-8077-755d5971d455.png',
            title: 'Kuryer gəldi',
            time: 'Last Wednesday at 9:42 AM',
          ),
          // Buraya başqa bildirişlər də əlavə edə bilərsən
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String iconUrl,
    required String title,
    required String time,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFDDDEE1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Image.network(
                iconUrl,
                width: 12,
                height: 12,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.inter(
              color: const Color(0xFF1A1F36),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            time,
            style: GoogleFonts.inter(
              color: const Color(0xFFA5ACB8),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Divider(color: const Color(0xFFE4E8EE), height: 1),
      ],
    );
  }
}
