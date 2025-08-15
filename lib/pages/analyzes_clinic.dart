import 'package:flutter/material.dart';
import 'package:safatapp/components/clinic_reservation_card.dart';
import 'package:safatapp/components/doctor_reservation_card.dart';

class AnalyzesClinic extends StatelessWidget {
  const AnalyzesClinic({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,

        childAspectRatio: MediaQuery.of(context).size.height > 850 ? 0.8 : 0.67,
      ),
      itemCount: 1,
      itemBuilder: (context, index) {
        return const ClinicReservationCard();
      },
    );
  }
}
