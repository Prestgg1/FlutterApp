import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
/* TODO: Burası lazımsız*/
class RatingTag extends StatelessWidget {
  final String rating;

  const RatingTag({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 22,
      left: 0,
      child: ClipPath(
        clipper: TagClipper(),
        child: Container(
          width: 40,
          height: 20,
          alignment: Alignment.center,
          color: const Color.fromRGBO(255, 208, 167, 0.47),
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 12),
              Text(
                rating,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 213, 87, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final cut = 6.0; // üçbucaq dərinliyi

    final path = Path();
    path.moveTo(0, 0); // sol yuxarı
    path.lineTo(size.width, 0); // sağ yuxarı
    path.lineTo(
      size.width - cut,
      size.height / 2,
    ); // sağdan içəri üçbucağın ucu
    path.lineTo(size.width, size.height); // sağ aşağı
    path.lineTo(0, size.height); // sol aşağı
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DoctorReservationCard extends StatefulWidget {
  const DoctorReservationCard({super.key});

  @override
  State<DoctorReservationCard> createState() => _DoctorReservationCardState();
}

class _DoctorReservationCardState extends State<DoctorReservationCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              ClipOval(
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0S4Cv9GzpkFeQFL3zg0b%2Fe198394767c327a4e68baa31797246c30c25ffe7Ellipse%20141.png?alt=media&token=aaaa7e51-6601-4f71-87e7-d51a19eb6dec',
                  width: 72,
                  height: 72,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 72,
                      height: 72,
                      color: Colors.grey.shade200,
                      child: Icon(Icons.person, size: 36, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Dr. Aysun",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                "Klinika: Yoxdur",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Container(
                color: Colors.grey.shade200,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  "Psixologiya",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 116,
                height: 12,
                child: Text(
                  'Analiz nəticəniz göndərilib.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: const Color(0xFF0F312D),
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  context.go("/doctors");
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Həkimin rəyini oxu',

                  textAlign: TextAlign.center,
                  softWrap: false,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ),
        RatingTag(rating: "4.5"),
      ],
    );
  }
}
