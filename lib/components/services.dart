import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorServices extends StatelessWidget {
  const DoctorServices({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
   /*     Flexible(
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bu xidmət hələ icra olunmur.')),
              );
            },
            child: ServiceBox(
              icon: Icons.receipt,
              title: "Resept Yazdır",
              price: "₼ 50 AZN",
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bu xidmət hələ icra olunmur.')),
              );
            },
            child: ServiceBox(
              icon: Icons.medical_information,
              title: "Analiz cavabını yoxla",
              price: "₼ 50 AZN",
            ),
          ),
        ),  
        const SizedBox(width: 8),
        */
        
        Center(
          child: GestureDetector(
            onTap: () {
              context.go('/doctor-appointment/$id');
            },
            child: ServiceBox(
              icon: Icons.calendar_today,
              title: "Rezervasiya təyin et",
              price: "₼ 50 AZN",
            ),
          ),
        ),
      ],
    );
  }
}

class ServiceBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String price;

  const ServiceBox({
    super.key,
    required this.icon,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, // Sabit hündürlük

      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 6),
                Text(price, style: const TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
