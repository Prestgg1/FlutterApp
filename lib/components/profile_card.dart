import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;

import 'package:safatapp/services/api.dart';

class ProfileCard extends StatefulWidget {
  ProfileCard({super.key, required this.token});

  final String token;
  backend.ResponseMeApiAuthMeGet? user;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late final backend.Openapi api;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    api = ApiService().api;
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    setState(() => loading = true);
    print(widget.token);

    try {
      final response = await api.getAuthApi().meApiAuthMeGet(
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );
      setState(() {
        widget.user = response.data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    // UserBase obyektini çıxarırıq
    final userBase =
        widget.user?.anyOf.values.entries.first.value as backend.UserBase?;
    final imageUrl = userBase?.image?.anyOf.values.entries.first.value
        .toString(); // Şəkil URL
    final name =
        userBase?.name?.anyOf.values.entries.first.value.toString() ?? ''; // Ad
    final email = userBase?.email ?? ''; // Email

    return Row(
      children: [
        CircleAvatar(
          radius: 25,

          backgroundImage: imageUrl != null && imageUrl.isNotEmpty
              ? NetworkImage(imageUrl)
              : const AssetImage('assets/default_avatar.png') as ImageProvider,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Salam ${userBase?.name?.anyOf.values.entries.first.value.toString() ?? 'Zehmet olmasa adızı girin'}",
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
