import 'package:flutter/material.dart';
import 'package:safatapp/components/doctor_categories.dart';
import 'package:safatapp/components/adbanner.dart';
import 'package:safatapp/components/doctors_section.dart';
import 'package:safatapp/components/clinic_section.dart';
import 'package:safatapp/components/pharmacies_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safatapp/components/profile_card.dart';
import 'package:safatapp/services/auth/authbloc.dart';
import 'package:safatapp/services/auth/authstate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: ProfileCard(user: state.user),
                  );
                } else if (state is Unauthenticated) {
                  return const SizedBox();
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            DoctorCategoriesWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: AdBanner(),
            ),
            DoctorHorizontalList(),
       /*     SizedBox(height: 16),
            ClinicHorizontalList(),
            SizedBox(height: 16),
            PharmaciesHorizontalList(),
            SizedBox(height: 16), */
          ],
        ),
      ),
    );
  }
}
