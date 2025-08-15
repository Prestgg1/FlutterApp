import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Tarih formatlama için

class AppointmentCalendar extends StatefulWidget {
  const AppointmentCalendar({super.key, required this.onDateSelected});
  final Function onDateSelected;

  @override
  State<AppointmentCalendar> createState() => _AppointmentCalendarState();
}

class _AppointmentCalendarState extends State<AppointmentCalendar> {
  DateTime selectedDate = DateTime.now(); // Seçili tarih
  DateTime currentMonth = DateTime(DateTime.now().year, DateTime.now().month);

  // O ayın günlerini döndüren fonksiyon
  List<List<DateTime?>> _getCalendarDays(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final daysBefore = firstDayOfMonth.weekday - 1; // Pazartesi = 1
    final daysAfter = 7 - lastDayOfMonth.weekday;

    final days = <DateTime?>[];

    // Önceki ayın boş günleri
    for (var i = 0; i < daysBefore; i++) {
      days.add(null);
    }

    // Bu ayın günleri
    for (var i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(month.year, month.month, i));
    }

    // Sonraki ayın boş günleri
    for (var i = 0; i < daysAfter; i++) {
      days.add(null);
    }

    // Haftalara böl
    final weeks = <List<DateTime?>>[];
    for (var i = 0; i < days.length; i += 7) {
      weeks.add(days.sublist(i, i + 7));
    }
    return weeks;
  }

  void _changeMonth(int value) {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final weeks = _getCalendarDays(currentMonth);
    final monthName = DateFormat.yMMMM().format(
      currentMonth,
    ); // "February 2021"

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Ay başlığı
          Container(
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFF248C76),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: () => _changeMonth(-1),
                ),
                Text(
                  monthName,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: () => _changeMonth(1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Gün adları
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
                  .map(
                    (dayName) => SizedBox(
                      width: 34,
                      child: Center(
                        child: Text(
                          dayName,
                          style: GoogleFonts.poppins(fontSize: 15),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 5),

          // Günler
          ...weeks.map((week) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: week.map((day) {
                  bool isSelected =
                      day != null &&
                      day.year == selectedDate.year &&
                      day.month == selectedDate.month &&
                      day.day == selectedDate.day;

                  return SizedBox(
                    width: 34,
                    height: 34,
                    child: day == null
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = day;
                              });
                              widget.onDateSelected(selectedDate);
                            },
                            child: Container(
                              decoration: isSelected
                                  ? BoxDecoration(
                                      color: const Color(0x7000A17E),
                                      borderRadius: BorderRadius.circular(17),
                                    )
                                  : null,
                              alignment: Alignment.center,
                              child: Text(
                                day.day.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                  );
                }).toList(),
              ),
            );
          }).toList(),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
