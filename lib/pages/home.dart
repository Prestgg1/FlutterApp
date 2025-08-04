import 'package:flutter/material.dart';
import 'package:sefatapp2/components/doctor_categories.dart';
import 'package:sefatapp2/components/adbanner.dart';
import 'package:sefatapp2/components/doctors_section.dart';
import 'package:sefatapp2/components/clinic_section.dart';
import 'package:sefatapp2/components/pharmacies_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            DoctorCategoriesWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: AdBanner(),
            ),
            DoctorHorizontalList(),
            SizedBox(height: 16),
            ClinicHorizontalList(),
            SizedBox(height: 16),
            PharmaciesHorizontalList(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
