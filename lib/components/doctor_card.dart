import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/favorite_btn.dart';

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

class DoctorCard extends StatefulWidget {
  final backend.DoctorOut doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.doctor.hasFavorited;
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.doctor.user;
    final category = widget.doctor.doctorCategory;

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
                  user.image,
                  width: 72,
                  height: 72,
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
                "Dr. ${user.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                "Klinika: ${widget.doctor.clinic ?? 'Yoxdur'}",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
                  category.title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.go("/doctors/${widget.doctor.id}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Rezerv et'),
              ),
            ],
          ),
        ),
        FavoriteBtn(
          type: backend.FavoriteType.doctor,
          id: "${widget.doctor.id}",
          isFavorite: widget.doctor.hasFavorited,
        ),
        RatingTag(rating: widget.doctor.averageRating.toString()),
      ],
    );
  }
}
