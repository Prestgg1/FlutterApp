import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Rezerves extends StatelessWidget {
  Rezerves({super.key});

  final List<Map<String, String>> reservations = List.generate(3, (index) {
    final rnd = Random();
    final serviceTypes = ['MRT', 'USM', 'Rentgen'];
    final clinics = ['Bonadea', 'Mediland', 'City Clinic'];
    final statuses = ['Rezerv təsdiq olunub', 'Gözləmədə', 'İmtina edildi'];

    return {
      'id': (rnd.nextInt(90000) + 10000).toString(),
      'status': statuses[rnd.nextInt(statuses.length)],
      'service': serviceTypes[rnd.nextInt(serviceTypes.length)],
      'clinic': clinics[rnd.nextInt(clinics.length)],
      'payment': rnd.nextBool() ? 'Ödənilib' : 'Ödənilməyib',
      'date': '${rnd.nextInt(28) + 1}/09 , Saat : ${rnd.nextInt(12) + 8}:00',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0S4Cv9GzpkFeQFL3zg0b%2Fc566791e6787fa8db811a12de477880081db60baunsplash%3AJ6MK67MIs0I.png?alt=media&token=9fe5a07a-2e1f-4606-8b4f-d1768d68f460',
    };
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final data = reservations[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ReservationCard(
              id: data['id']!,
              status: data['status']!,
              service: data['service']!,
              clinic: data['clinic']!,
              payment: data['payment']!,
              date: data['date']!,
              imageUrl: data['image']!,
            ),
          );
        },
      ),
    );
  }
}

class ReservationCard extends StatelessWidget {
  final String id;
  final String status;
  final String service;
  final String clinic;
  final String payment;
  final String date;
  final String imageUrl;

  const ReservationCard({
    super.key,
    required this.id,
    required this.status,
    required this.service,
    required this.clinic,
    required this.payment,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1E000000),
            offset: Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(22),
            ),
            child: Image.network(
              imageUrl,
              width: 140,
              height: 190,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    id,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF0F312D),
                    ),
                  ),
                  Text(
                    status,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F312D),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Xidmət növü: $service\nKlinika: $clinic\nÖdəniş: $payment',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      height: 1.5,
                      color: const Color(0xFF226C63),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 10,
                        color: Color(0xFF0F312D),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: GoogleFonts.poppins(
                          fontSize: 8,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: const Color(0xFF226C63),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: Text(
                              'Nəticəni yolla',
                              style: GoogleFonts.poppins(
                                fontSize: 8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 0.5,
                              color: const Color(0xFF226C63),
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: Text(
                              'İmtina et',
                              style: GoogleFonts.poppins(
                                fontSize: 8,
                                color: const Color(0xFF226C63),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
