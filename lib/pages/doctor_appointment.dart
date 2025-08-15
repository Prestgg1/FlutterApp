import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safatapp/components/calendar.dart';
import 'package:safatapp/services/appointment/appointment_bloc.dart';
import 'package:safatapp/services/appointment/appointment_event.dart';

class DoctorAppointmentPage extends StatefulWidget {
  const DoctorAppointmentPage({super.key});

  @override
  State<DoctorAppointmentPage> createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  DateTime? selectedDate;

  Widget _timeButton(String time, {bool selected = false}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFD9EBE7) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: selected
            ? []
            : [
                const BoxShadow(
                  color: Color(0x3F000000),
                  offset: Offset(0, 3),
                  blurRadius: 4,
                ),
              ],
      ),
      alignment: Alignment.center,
      child: Text(
        time,
        textAlign: TextAlign.center,
        style: GoogleFonts.rubik(
          fontSize: selected ? 14 : 13,
          color: selected ? const Color(0xFF1F8871) : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reminderOptions = [
      {"label": "30\nMinit", "selected": false},
      {"label": "40\nMinit", "selected": false},
      {"label": "25\nMinit", "selected": true},
      {"label": "10\nMinit", "selected": false},
      {"label": "35\nMinit", "selected": false},
    ];

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: 430,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              AppointmentCalendar(
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              const SizedBox(height: 30),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Uyğun saatlar',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _timeButton('10:00\nAM'),
                  _timeButton('12:00\nAM'),
                  _timeButton('02:00\nPM', selected: true),
                  _timeButton('03:00\nPM'),
                  _timeButton('04:00\nPM'),
                ],
              ),
              const SizedBox(height: 15),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Xəbərdarlıq et',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: reminderOptions.map((option) {
                  return _timeButton(
                    option["label"],
                    selected: option["selected"],
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF226C63),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    if (selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Lütfen tarih seçin")),
                      );
                      return;
                    }

                    // 📌 BLoC’a tarihi kaydet
                    context.read<AppointmentBloc>().add(
                      AppointmentDateSelected(selectedDate!),
                    );

                    // 📌 Yönlendirme
                    context.go("/doctor-appointment-form");
                  },
                  child: Text(
                    'Dəvam et',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
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
