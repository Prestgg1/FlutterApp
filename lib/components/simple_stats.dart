import 'package:flutter/material.dart';

class SimpleStats extends StatelessWidget {
  final num averageRating;
  final int totalReviews;
  final int totalDoctors;
  final int totalPatients;

  const SimpleStats({
    Key? key,
    required this.totalDoctors,
    required this.totalPatients,
    required this.averageRating,
    required this.totalReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: Icon(
                Icons.group_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            Text(
              totalPatients.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Pasiyent',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: Icon(
                Icons.trending_up,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            Text(
              totalDoctors.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('Təcrübə', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        Column(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            Text(
              averageRating.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Ortalama',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            Text(
              totalReviews > 100 ? '100+' : totalReviews.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('Rəy', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
