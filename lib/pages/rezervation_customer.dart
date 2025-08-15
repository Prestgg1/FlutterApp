import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class RezervationCustomer extends StatelessWidget {
  RezervationCustomer({super.key});

  final List<Map<String, String>> reservations = [
    {
      "name": "Dr. Amin İbr",
      "specialty": "Psixoloq",
      "price": "60 azn",
      "clinic": "Bonadea",
      "date": "15/09 , Saat : 14:00",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0S4Cv9GzpkFeQFL3zg0b%2Fe198394767c327a4e68baa31797246c30c25ffe7Ellipse%20141.png?alt=media&token=1d38cfe9-937d-46c6-ba05-61b726d019b2",
    },
    // Eyni formatda 5 dəfə daha əlavə edirik
    {
      "name": "Dr. Amin İbr",
      "specialty": "Psixoloq",
      "price": "60 azn",
      "clinic": "Bonadea",
      "date": "15/09 , Saat : 14:00",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0S4Cv9GzpkFeQFL3zg0b%2Fe198394767c327a4e68baa31797246c30c25ffe7Ellipse%20141.png?alt=media&token=1d38cfe9-937d-46c6-ba05-61b726d019b2",
    },
    {
      "name": "Dr. Amin İbr",
      "specialty": "Psixoloq",
      "price": "60 azn",
      "clinic": "Bonadea",
      "date": "15/09 , Saat : 14:00",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0S4Cv9GzpkFeQFL3zg0b%2Fe198394767c327a4e68baa31797246c30c25ffe7Ellipse%20141.png?alt=media&token=1d38cfe9-937d-46c6-ba05-61b726d019b2",
    },
    {
      "name": "Dr. Amin İbr",
      "specialty": "Psixoloq",
      "price": "60 azn",
      "clinic": "Bonadea",
      "date": "15/09 , Saat : 14:00",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0S4Cv9GzpkFeQFL3zg0b%2Fe198394767c327a4e68baa31797246c30c25ffe7Ellipse%20141.png?alt=media&token=1d38cfe9-937d-46c6-ba05-61b726d019b2",
    },
    {
      "name": "Dr. Amin İbr",
      "specialty": "Psixoloq",
      "price": "60 azn",
      "clinic": "Bonadea",
      "date": "15/09 , Saat : 14:00",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0S4Cv9GzpkFeQFL3zg0b%2Fe198394767c327a4e68baa31797246c30c25ffe7Ellipse%20141.png?alt=media&token=1d38cfe9-937d-46c6-ba05-61b726d019b2",
    },
    {
      "name": "Dr. Amin İbr",
      "specialty": "Psixoloq",
      "price": "60 azn",
      "clinic": "Bonadea",
      "date": "15/09 , Saat : 14:00",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0S4Cv9GzpkFeQFL3zg0b%2Fe198394767c327a4e68baa31797246c30c25ffe7Ellipse%20141.png?alt=media&token=1d38cfe9-937d-46c6-ba05-61b726d019b2",
    },
  ];

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
      body: Padding(
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
      ),
    );
  }
}

// Artık her bir kart için ayrı bir widget oluşturduk
class ReservationCard extends StatelessWidget {
  final Map<String, String> item;

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
              child: Icon(Icons.favorite_border, color: Colors.grey),
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
                  item["image"]!,
                  width: 100,
                  height: 100,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item["name"]!,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                item["specialty"]!,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: const Color(0xFF226C63),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'Konsultasiya xidməti: ${item["price"]}\nKlinika: ${item["clinic"]}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    color: const Color(0xFF226C63),
                    height: 1.4,
                  ),
                ),
              ),
              Text(
                item["date"]!,
                style: GoogleFonts.poppins(
                  fontSize: 8,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF0F312D),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.push('/appointment-cancel');
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
