import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/doctor_card.dart';
import 'package:safatapp/services/api.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safatapp/services/auth/authbloc.dart';
import 'package:safatapp/services/auth/authevent.dart';
import 'package:safatapp/services/auth/authstate.dart';

class DoctorFavoritesHorizontalList extends StatefulWidget {
  const DoctorFavoritesHorizontalList({super.key});

  @override
  State<DoctorFavoritesHorizontalList> createState() =>
      _DoctorFavoritesHorizontalListState();
}

class _DoctorFavoritesHorizontalListState
    extends State<DoctorFavoritesHorizontalList> {
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
    final authState = context.read<AuthBloc>().state;
    if (authState is! Authenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Giriş tələb olunur"),
              content: Text(
                "Siz daxil olmamısınız. Zəhmət olmasa əvvəlcə daxil olun.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Daxil ol"),
                ),
              ],
            );
          },
        );

        await Future.delayed(Duration(milliseconds: 300));
        if (context.mounted) {
          context.go('/login');
        }
      });
      return;
    }

    final token = authState.token;
    try {
      final response = await api
          .getFavoritesApi()
          .getDoctorFavoritesApiFavoritesDoctorGet(
            headers: {'Authorization': 'Bearer $token'},
          );
      setState(() {
        doctors = response.data?.toList() ?? [];
        loading = false;
      });
    } catch (e) {
      print(e);
      setState(() => loading = false);
      if (e.toString().contains('401')) {
        context.read<AuthBloc>().add(AuthLogout());
        context.go('/login');
      }
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
