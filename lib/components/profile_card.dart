import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.user});

  final backend.UserBase? user;

  @override
  Widget build(BuildContext context) {
    final imageUrl = user?.image ?? '';
    final name = user?.name ?? '';
    final email = user?.email ?? '';

    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: imageUrl.isNotEmpty
              ? NetworkImage(imageUrl)
              : const AssetImage('assets/default_avatar.png') as ImageProvider,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Salam ${name.isNotEmpty ? name : 'Zehmet olmasa adızı girin'}",
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            Text(email, style: const TextStyle(fontSize: 10)),
          ],
        ),
      ],
    );
  }
}
