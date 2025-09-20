import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/services/api.dart';

class RezervationCustomer extends StatefulWidget {
  RezervationCustomer({super.key});

  @override
  State<RezervationCustomer> createState() => _RezervationCustomerState();
}

class _RezervationCustomerState extends State<RezervationCustomer> {
  late Future<List<backend.AppointmentsDoctorResponse>> reservationsFuture;

  @override
  void initState() {
    super.initState();
    reservationsFuture = getReservations();
  }

  Future<List<backend.AppointmentsDoctorResponse>> getReservations() async {
    try {
      final api = ApiService().api;
      final response = await api
          .getAppointmentApi()
          .getAppointmentsDoctorsApiAppointmentDoctorGet();

      if (response.statusCode == 200) {
        return response.data?.toList() ?? [];
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Rezervasiyalar',
          style: GoogleFonts.poppins(
            color: const Color(0xFF226C63),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<backend.AppointmentsDoctorResponse>>(
        future: reservationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 🔄 Loading spinner
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // ❌ Error durumunda
            return Center(child: Text("Xəta baş verdi: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final reservations = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: reservations.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = reservations[index];
                  return ReservationCard(item: item);
                },
              ),
            );
          } else {
            // 📭 Data boşsa
            return const Center(child: Text("Rezervasiya tapılmadı"));
          }
        },
      ),
    );
  }
}

// Artık her bir kart için ayrı bir widget oluşturduk
class ReservationCard extends StatelessWidget {
  final backend.AppointmentsDoctorResponse item;

  const ReservationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x23000000),
            spreadRadius: 0,
            offset: Offset(3, 3),
            blurRadius: 21,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Favorite icon
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.favorite_border, color: Colors.grey),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  item.user.image,
                  width: 100,
                  height: 100,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.user.name,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                item.doctorCategory.title,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: const Color(0xFF226C63),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'Konsultasiya xidməti: 60\nKlinika: ${item.clinic!.isNotEmpty ? item.clinic : 'Yoxdur'}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    color: const Color(0xFF226C63),
                    height: 1.4,
                  ),
                ),
              ),
              Text(
                item.date.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 8,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF0F312D),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.push('/appointment-cancel/${item.appointmentId}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF226C63),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Ləğv et',
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
