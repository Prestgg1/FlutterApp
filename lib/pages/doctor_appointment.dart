import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safatapp/components/calendar.dart';
import 'package:safatapp/services/appointment/appointment_bloc.dart';
import 'package:safatapp/services/appointment/appointment_event.dart';

class DoctorAppointmentPage extends StatefulWidget {
  const DoctorAppointmentPage({super.key, required this.modelId});

  final int modelId;

  @override
  State<DoctorAppointmentPage> createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  DateTime? selectedDate;
  String? selectedTime; // 👈 seçilmiş saatı saxlayırıq

  Widget _timeButton(String time, {bool selected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTime = time; // 👈 kliklənən saat seçilsin
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: (selectedTime == time)
              ? const Color(0xFFD9EBE7)
              : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: (selectedTime == time)
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
            fontSize: (selectedTime == time) ? 14 : 13,
            color: (selectedTime == time)
                ? const Color(0xFF1F8871)
                : Colors.black,
          ),
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

    return Container(
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
              /* Burada date seçilir. eğer date seçilmeyibse default olaraq indi zamanı seçilecek.  */
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
                  _timeButton('02:00\nPM'),
                  _timeButton('03:00\nPM'),
                  _timeButton('04:00\nPM'),
                ],
              ),
              /* Burada time seçilir. yuxarda elave olunmuş selectedDate deyerine elave olaraq time elave olunmalıdır. 
                 bu formada çıxmalıdır 2025-08-17T12:00:00Z formatında olmalıdır */
              const SizedBox(height: 15),

           /*   Align(
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
  */
              Spacer(), //Bu yazdigim spacer sayesinde uygulamam çözükyor
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
                    final date = selectedDate ?? DateTime.now();
                    if (selectedTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Zəhmət olmasa saat seçin")),
                      );
                      return;
                    }

                    // saat stringini parse et (örn: 02:00 PM)
                    final timeParts = selectedTime!
                        .split("\n")
                        .first; // "02:00"
                    final isPM = selectedTime!.contains("PM");
                    var hour = int.parse(timeParts.split(":")[0]);
                    final minute = int.parse(timeParts.split(":")[1]);

                    if (isPM && hour != 12) hour += 12;
                    if (!isPM && hour == 12) hour = 0;

                    final combinedDateTime = DateTime.utc(
                      date.year,
                      date.month,
                      date.day,
                      hour,
                      minute,
                    );

                    final isoString = combinedDateTime
                        .toUtc()
                        .toIso8601String();
                    print("📅 Seçilmiş tarix və saat: $isoString");

                    // 📌 BLoC’a tarixi + saatı göndər
                    context.read<AppointmentBloc>().add(
                      AppointmentDateSelected(combinedDateTime),
                    );

                    // 📌 Yönlendirme
                    context.go("/doctor-appointment-form/${widget.modelId}");
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
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
