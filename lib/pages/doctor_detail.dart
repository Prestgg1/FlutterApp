import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/expandable.dart';
import 'package:safatapp/components/review_input.dart';
import 'package:safatapp/components/reviews_section.dart';
import 'package:safatapp/components/services.dart';
import 'package:safatapp/components/simple_stats.dart';
import 'package:safatapp/services/api.dart';

class DoctorDetailPage extends StatefulWidget {
  final int id;

  const DoctorDetailPage({super.key, required this.id});

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  backend.DoctorResponse? doctor;
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
      final response = await api.getDoctorsApi().getDoctorApiDoctorsDoctorIdGet(
        doctorId: widget.id,
      );

      setState(() {
        doctor = response.data;
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
          : doctor == null
          ? const Center(child: Text('Həkim tapılmadı'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // istədiyin radius dəyəri
                      child: Image.network(
                        doctor!.user.image?.anyOf.values.entries.first.value
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
                              doctor!.user.name,
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              "${doctor!.doctorCategory.title} | Klinika: ${doctor!.clinic?.toString() ?? 'Yoxdur'}",
                              style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            Text(
                              doctor!.averageRating.toString(),
                              style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " (${doctor!.totalReviews}) reviews",
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

                    SimpleStats(
                      totalDoctors: doctor!.workExperience,
                      totalPatients: doctor!.patientCount,
                      averageRating: doctor!.averageRating,
                      totalReviews: doctor!.totalReviews,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Xidmətlər',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DoctorServices(),
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
                          doctor!.abouts?.anyOf.values.entries.first.value
                              .toString() ??
                          'Haqqında məlumat yoxdur ',
                    ),
                    const SizedBox(height: 16),
                    ReviewInput(
                      onSend: (message) {
                        // burada mesajı göndərmək istəsən
                      },
                    ),
                    Reviews(model_id: doctor!.id, model: "doctor"),
                  ],
                ),
              ),
            ),
    );
  }
}
