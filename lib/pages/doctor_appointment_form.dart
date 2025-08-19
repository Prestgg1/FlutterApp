import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safatapp/components/appointmentformfields.dart';

class DoctorAppointmentScreen extends StatelessWidget {
  const DoctorAppointmentScreen({super.key, required this.modelId});

  final int modelId;

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

              /// Form sahəsi ayrıca widget
              AppointmentFormFields(modelId: modelId),
            ],
          ),
        ),
      ),
    );
  }
}
