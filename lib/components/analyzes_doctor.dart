import 'package:flutter/material.dart';
import 'package:safatapp/components/doctor_reservation_card.dart';

class AnalyzesDoctor extends StatelessWidget {
  const AnalyzesDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: MediaQuery.of(context).size.height > 850 ? 0.6 : 0.67,
      ),
      itemCount: 1,
      itemBuilder: (context, index) {
        return const DoctorReservationCard();
      },
    );
  }
}
