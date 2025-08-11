import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/ratingStars.dart';

class ClinicCard extends StatefulWidget {
  final backend.ClinicsResponse clinic;

  const ClinicCard({super.key, required this.clinic});

  @override
  State<ClinicCard> createState() => _ClinicCardState();
}

class _ClinicCardState extends State<ClinicCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.clinic.hasFavorited;
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.clinic.user;

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
                  user.image?.anyOf.values.entries.first.value.toString() ?? '',
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
                user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
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
                  "Yaxında",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingStars(rating: widget.clinic.averageRating.toDouble()),
                  Text(
                    " ${widget.clinic.reviewsCount} rəy",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/clinic/${widget.clinic.id}');
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
      ],
    );
  }
}
