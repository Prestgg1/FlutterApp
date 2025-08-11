import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/expandable.dart';
import 'package:safatapp/components/review_input.dart';
import 'package:safatapp/components/reviews_section.dart';
import 'package:safatapp/components/simple_stats.dart';
import 'package:safatapp/services/api.dart';

class ClinicDetailPage extends StatefulWidget {
  final int id;

  const ClinicDetailPage({super.key, required this.id});

  @override
  State<ClinicDetailPage> createState() => _ClinicDetailPageState();
}

class _ClinicDetailPageState extends State<ClinicDetailPage> {
  backend.ClinicResponse? clinic;
  bool loading = true;
  late final backend.Openapi api;

  @override
  void initState() {
    super.initState();
    api = ApiService().api;
    fetchDoctor();
  }

  Future<void> fetchDoctor() async {
    try {
      final response = await api.getClinicApi().getClinicApiClinicClinicIdGet(
        clinicId: widget.id,
      );

      setState(() {
        clinic = response.data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : clinic == null
          ? const Center(child: Text('Klinika tapılmadı'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        clinic!.user.image?.anyOf.values.entries.first.value
                                .toString() ??
                            '',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 200,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              clinic!.user.name,
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            Text(
                              clinic!.averageRating.toString(),
                              style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " (${clinic!.reviewsCount}) reviews",
                              style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Text(
                      clinic!.city,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      clinic!.address,
                      style: TextStyle(fontSize: screenWidth * 0.03),
                      softWrap: true,
                    ),
                    SimpleStats(
                      totalDoctors: clinic!.workExperience,
                      totalPatients: clinic!.patientCount,
                      averageRating: clinic!.averageRating,
                      totalReviews: clinic!.reviewsCount,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 40),
                          backgroundColor: Colors.white,
                          foregroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        onPressed: () {
                          context.go('/brunches/${clinic!.id}');
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Şöbələr',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Haqqında',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 32),
                    ExpandableText(
                      text:
                          clinic!.about?.anyOf.values.entries.first.value
                              .toString() ??
                          'Haqqında məlumat yoxdur ',
                    ),
                    const SizedBox(height: 16),
                    ReviewInput(
                      onSend: (message) {
                        // burada mesajı göndərmək istəsən
                      },
                    ),
                    Reviews(model_id: clinic!.id, model: "clinic"),
                  ],
                ),
              ),
            ),
    );
  }
}
