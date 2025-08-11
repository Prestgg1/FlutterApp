import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorAppointmentForm extends StatelessWidget {
  const DoctorAppointmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Text(
                'Filan həkimdən rezrvasiya almaq üçün aşağıdakı xanaları doldurun',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40),

              // Ad Soyad
              _buildLabel('Ad Soyad'),
              _buildInput(hint: 'Ad soyad'),
              const SizedBox(height: 20),

              // Mobil nömrə
              _buildLabel('Mobil nömrə'),
              _buildInput(hint: 'Mobil nömrə'),
              const SizedBox(height: 20),

              // Fin kod
              _buildLabel('Fin kod'),
              _buildInput(hint: 'Fin kod'),
              const SizedBox(height: 20),

              // Şikayət
              _buildLabel('Şikayətinizi qeyd edin'),
              _buildInput(hint: 'Şikayətinizi qeyd edin', maxLines: 5),
              const SizedBox(height: 50),

              // Button
              SizedBox(
                width: 183,
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF226C63),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Dəvam et',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFDEE9E8),
                      fontSize: 15,
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

  // Label widget
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: const Color(0xFF1F8871),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildInput({required String hint, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: const Color(0x701F8871),
          fontSize: 13,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF1F8871), width: 1.1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF1F8871), width: 1.3),
        ),
      ),
    );
  }
}
