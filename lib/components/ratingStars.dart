import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index + 1 <= rating) {
          // Tam ulduz
          return Icon(Icons.star, color: Colors.yellow, size: 18);
        } else if (index + 0.5 <= rating) {
          // Yarım ulduz
          return Icon(Icons.star_half, color: Colors.yellow, size: 18);
        } else {
          // Boş ulduz
          return Icon(Icons.star, color: Colors.grey, size: 18);
        }
      }),
    );
  }
}
