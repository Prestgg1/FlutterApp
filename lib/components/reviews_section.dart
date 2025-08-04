import 'package:flutter/material.dart';
import 'package:sefatapp2/components/ratingStars.dart';
import 'package:sefatapp2/services/api.dart';
import 'package:openapi/openapi.dart' as backend;

class Reviews extends StatefulWidget {
  final int model_id;
  final String model;

  const Reviews({super.key, required this.model_id, required this.model});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool loading = true;
  List<backend.ReviewResponse> reviews = []; // sadə nümunə üçün
  late final backend.Openapi api;

  @override
  void initState() {
    super.initState();
    api = ApiService().api;
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      final response = await api
          .getReviewsApi()
          .getReviewsForModelApiReviewsModelModelIdGet(
            model: widget.model,
            modelId: widget.model_id,
          ); // öz route-unla əvəz et

      setState(() {
        reviews = response.data?.toList() ?? [];
        loading = false;
      });
    } catch (e) {
      setState(() {
        print(e);
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (reviews.isEmpty) {
      return const Text("Hələki bir rəy yoxdur.");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final r in reviews)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              padding: const EdgeInsets.all(8),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          r.author.image.toString(),
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 36,
                              height: 36,
                              color: Colors.grey.shade200,
                              child: Icon(Icons.person, size: 24),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.author.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          RatingStars(rating: r.rating.toDouble()),
                          Text(r.review),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
