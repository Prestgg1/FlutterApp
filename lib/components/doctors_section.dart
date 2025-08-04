import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:sefatapp2/components/doctor_card.dart';
import 'package:sefatapp2/services/api.dart';
import 'package:go_router/go_router.dart';

class DoctorHorizontalList extends StatefulWidget {
  const DoctorHorizontalList({super.key});

  @override
  State<DoctorHorizontalList> createState() => _DoctorHorizontalListState();
}

class _DoctorHorizontalListState extends State<DoctorHorizontalList> {
  List<backend.DoctorOut> doctors = [];
  bool loading = true;
  late final backend.Openapi api;

  @override
  void initState() {
    super.initState();
    api = ApiService().api;
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    setState(() => loading = true);
    try {
      final response = await api.getDoctorsApi().listDoctorsApiDoctorsGet();
      setState(() {
        doctors = response.data?.toList() ?? [];
        loading = false;
      });
    } catch (e) {
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

    if (doctors.isEmpty) {
      return const SizedBox(
        height: 280,
        child: Center(
          child: Text(
            'Həkim tapılmadı',
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
            onTap: () => context.go('/doctors'),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Sadece içindəkilər qədər en
              children: [
                Text(
                  "Həkimlər",
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
            itemCount: doctors.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return SizedBox(width: 160, child: DoctorCard(doctor: doctor));
            },
          ),
        ),
      ],
    );
  }
}
