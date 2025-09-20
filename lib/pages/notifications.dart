import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  Future<List<Map<String, String>>> fetchNotifications() async {
    // Burada öz API çağırışını edəcəksən (http və ya dio ilə)
    await Future.delayed(const Duration(seconds: 2)); // Fake delay (loading göstərmək üçün)

    // Test üçün boş qaytarmaq:
    // return [];

    // Test üçün data qaytarmaq:
    return [
    
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading göstərmək üçün
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // API error gələndə
            return Center(
              child: Text(
                "Xəta baş verdi: ${snapshot.error}",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final notifications = snapshot.data!;
            if (notifications.isEmpty) {
              return Center(
                child: Text(
                  "Sizə hal hazırda bildiriş gəlməyib",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF1A1F36),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: notifications.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: Color(0xFFE4E8EE), height: 1),
              itemBuilder: (context, index) {
                final item = notifications[index];
                return _buildNotificationItem(
                  iconUrl: item["iconUrl"] ?? "",
                  title: item["title"] ?? "",
                  time: item["time"] ?? "",
                );
              },
            );
          } else {
            return const Center(child: Text("Naməlum vəziyyət"));
          }
        },
      ),
    );
  }

  Widget _buildNotificationItem({
    required String iconUrl,
    required String title,
    required String time,
  }) {
    return ListTile(
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
    );
  }
}
