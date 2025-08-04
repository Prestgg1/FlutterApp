import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:sefatapp2/components/clinic_card.dart';
import 'package:sefatapp2/services/api.dart';
import 'package:go_router/go_router.dart';

class ClinicHorizontalList extends StatefulWidget {
  const ClinicHorizontalList({super.key});

  @override
  State<ClinicHorizontalList> createState() => _ClinicHorizontalListState();
}

class _ClinicHorizontalListState extends State<ClinicHorizontalList> {
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
    try {
      final response = await api.getClinicsApi().getClinicsApiClinicsGet(
        limit: 8,
      );
      setState(() {
        clinics = response.data?.toList() ?? [];
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
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
