import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:go_router/go_router.dart';
import 'package:safatapp/components/ratingStars.dart';

class PharmacyCard extends StatefulWidget {
  final backend.PharmaciesResponse pharmacy;

  const PharmacyCard({super.key, required this.pharmacy});

  @override
  State<PharmacyCard> createState() => _PharmacyCardState();
}

class _PharmacyCardState extends State<PharmacyCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.pharmacy.hasFavorited;
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.pharmacy.user;

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

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: Colors.grey.shade200,
                child: Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),

              const SizedBox(height: 4),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3,
                  ), // soldan və sağdan boşluq
                  child: Text(
                    "Adress: ${widget.pharmacy.city}",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingStars(rating: widget.pharmacy.averageRating.toDouble()),
                  Text(
                    " ${widget.pharmacy.reviewsCount} rəy",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/pharmacy/${widget.pharmacy.id}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Alış veriş et'),
              ),
            ],
          ),
        ),
        Positioned(top: 8, left: 8, child: Text("7/24")),
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
