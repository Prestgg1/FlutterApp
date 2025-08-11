import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/clinic_card.dart';
import 'package:safatapp/services/api.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safatapp/services/auth/authbloc.dart';
import 'package:safatapp/services/auth/authstate.dart';

class ClinicFavoriteHorizontalList extends StatefulWidget {
  const ClinicFavoriteHorizontalList({super.key});

  @override
  State<ClinicFavoriteHorizontalList> createState() =>
      _ClinicFavoriteHorizontalListState();
}

class _ClinicFavoriteHorizontalListState
    extends State<ClinicFavoriteHorizontalList> {
  List<backend.ClinicsResponse> clinics = [];
  bool loading = true;
  late final backend.Openapi api;

  @override
  void initState() {
    super.initState();
    api = ApiService().api;

    fetchClinics();
  }

  Future<void> fetchClinics() async {
    setState(() => loading = true);
    final authState = context.read<AuthBloc>().state;
    if (authState is! Authenticated) {
      setState(() => loading = false);
      return;
    }

    final token = authState.token;
    try {
      final response = await api
          .getFavoritesApi()
          .getClinicFavoritesApiFavoritesClinicGet(
            headers: {'Authorization': 'Bearer $token'},
          );
      setState(() {
        clinics = response.data?.toList() ?? [];
        loading = false;
      });
    } catch (e) {
      // Lazım gələrsə, səhv mesajı da göstərə bilərsən
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

    if (clinics.isEmpty) {
      return const SizedBox(
        height: 280,
        child: Center(
          child: Text(
            'Klinik tapılmadı',
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
            onTap: () => context.go('/clinics'),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Sadece içindəkilər qədər en
              children: [
                Text(
                  "Klinikalar",
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
            itemCount: clinics.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final clinic = clinics[index];
              return SizedBox(width: 160, child: ClinicCard(clinic: clinic));
            },
          ),
        ),
      ],
    );
  }
}
