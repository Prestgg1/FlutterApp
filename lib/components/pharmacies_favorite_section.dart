import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/pharmacy_card.dart';
import 'package:safatapp/services/api.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safatapp/services/auth/authbloc.dart';
import 'package:safatapp/services/auth/authevent.dart';
import 'package:safatapp/services/auth/authstate.dart';

class PharmaciesFavoriteHorizontalList extends StatefulWidget {
  const PharmaciesFavoriteHorizontalList({super.key});

  @override
  State<PharmaciesFavoriteHorizontalList> createState() =>
      _PharmaciesFavoriteHorizontalListState();
}

class _PharmaciesFavoriteHorizontalListState
    extends State<PharmaciesFavoriteHorizontalList> {
  List<backend.PharmaciesResponse> pharmacies = [];
  bool loading = true;
  late final backend.Openapi api;

  @override
  void initState() {
    super.initState();
    api = ApiService().api;
    fetchPharmacies();
  }

  Future<void> fetchPharmacies() async {
    setState(() => loading = true);
    final authState = context.read<AuthBloc>().state;
    if (authState is! Authenticated) {
      setState(() => loading = false);
      return;
    }

    try {
      final response = await api
          .getFavoritesApi()
          .getPharmacyFavoritesApiFavoritesPharmacyGet();
      setState(() {
        pharmacies = response.data?.toList() ?? [];
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Column(
        children: [
          SizedBox(
            height: 280,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }

    if (pharmacies.isEmpty) {
      return const SizedBox(
        height: 280,
        child: Center(
          child: Text(
            'Aptek tapılmadı',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => context.go('/pharmacies'),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Sadece içindəkilər qədər en
              children: [
                Text(
                  "Apteklər",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8), // Text ilə ox arası boşluq
                Icon(
                  Icons.arrow_forward,
                  size: 24, // Text-in fontuna uyğun ölçü
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: pharmacies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final pharmacy = pharmacies[index];
              return SizedBox(
                width: 160,
                child: PharmacyCard(pharmacy: pharmacy),
              );
            },
          ),
        ),
      ],
    );
  }
}
