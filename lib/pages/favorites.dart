import 'package:flutter/material.dart';
import 'package:safatapp/components/adbanner.dart';
import 'package:safatapp/components/clinic_favorite_detail.dart';
import 'package:safatapp/components/doctors_favorites_section.dart';
import 'package:safatapp/components/clinic_section.dart';
import 'package:safatapp/components/pharmacies_favorite_section.dart';
import 'package:safatapp/components/pharmacies_section.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            DoctorFavoritesHorizontalList(),

            SizedBox(height: 16),
            ClinicFavoriteHorizontalList(),
            SizedBox(height: 16),
            PharmaciesFavoriteHorizontalList(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
