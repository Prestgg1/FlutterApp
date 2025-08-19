import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safatapp/services/api.dart';

class AppointmentReason extends StatefulWidget {
  const AppointmentReason({super.key, required this.id});

  final String id;

  @override
  State<AppointmentReason> createState() => _AppointmentReasonState();
}

class _AppointmentReasonState extends State<AppointmentReason> {
  final TextEditingController _reasonController = TextEditingController();
  bool _isLoading = false;

  Future<void> cancelAppointment() async {
    final reason = _reasonController.text.trim();

    // ✅ Sadə validasiya
    if (reason.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Ləğv səbəbi boş ola bilməz")));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final api = ApiService().api;
      final response = await api
          .getAppointmentApi()
          .cancelAppointmentApiAppointmentItemIdPut(
            itemId: int.parse(widget.id),
            reason: reason,
          );

      if (response.statusCode == 200) {
        context.go("/appointment-cancelled");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Xəta: ${response.statusMessage ?? "Bilinməyən xəta"}",
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Xəta baş verdi: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20), // Etraf boşluq
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),

              // Başlıq
              Text(
                'Rezervasiyanızı ləğv etmək istəyirsiniz',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF226C63),
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 40),

              // Input
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.1,
                    color: const Color(0xFF1F8871),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _reasonController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Səbəbini qeyd edin',
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0x701F8871),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Tamamla butonu
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF226C63),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: _isLoading ? null : cancelAppointment,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Tamamla',
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
        ),
      ),
    );
  }
}
