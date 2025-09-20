import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/expandable.dart';
import 'package:safatapp/components/review_input.dart';
import 'package:safatapp/components/reviews_section.dart';
import 'package:safatapp/components/simple_stats.dart';
import 'package:safatapp/services/api.dart';

class PharmacyDetailPage extends StatefulWidget {
  final int id;

  const PharmacyDetailPage({super.key, required this.id});

  @override
  State<PharmacyDetailPage> createState() => _PharmacyDetailPageState();
}

class _PharmacyDetailPageState extends State<PharmacyDetailPage> {
  backend.PharmacyResponse? pharmacy;
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
      final response = await api
          .getPharmacyApi()
          .getPharmacyApiPharmaciesPharmacyIdGet(pharmacyId: widget.id);

      setState(() {
        pharmacy = response.data;
        loading = false;
      });
    } catch (e) {
      print(e);
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
          : pharmacy == null
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
                        pharmacy!.user.image,
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
                              pharmacy!.user.name,
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
                              pharmacy!.averageRating.toString(),
                              style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " (${pharmacy!.reviewsCount}) reviews",
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
                      pharmacy!.city,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      pharmacy!.address,
                      style: TextStyle(fontSize: screenWidth * 0.03),
                      softWrap: true,
                    ),
                    SimpleStats(
                      totalDoctors: pharmacy!.workExperience,
                      totalPatients: pharmacy!.patientCount,
                      averageRating: pharmacy!.averageRating,
                      totalReviews: pharmacy!.reviewsCount,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(140, 40),
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
                          context.go('/shop/${pharmacy!.id}');
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Məhsullar',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
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
                          pharmacy!.about
                              .toString(),
                    ),
                    const SizedBox(height: 16),
                    Reviews(modelId: pharmacy!.id, model: "pharmacy"),
                  ],
                ),
              ),
            ),
    );
  }
}
