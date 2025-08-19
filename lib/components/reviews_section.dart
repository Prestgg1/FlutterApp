import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safatapp/services/api.dart';
import 'package:openapi/openapi.dart' as backend;
import "../services/auth/authstate.dart";
import 'reviewcard.dart';
import 'review_input.dart'; // 🔹 ReviewInput componenti ayrıca faylda olmalıdır
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safatapp/services/auth/authbloc.dart';

class Reviews extends StatefulWidget {
  final int modelId;
  final String model;

  const Reviews({super.key, required this.modelId, required this.model});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool loading = true;
  List<backend.ReviewsResponse> reviews = [];
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
            modelId: widget.modelId,
          );

      setState(() {
        reviews = response.data?.toList() ?? [];
        loading = false;
      });
    } catch (e) {
      setState(() {
        debugPrint("Review fetch error: $e");
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReviewInput(
            onSend: (message, rating) {
              final authState = context.read<AuthBloc>().state;
              if (authState is! Authenticated) {
                context.go('/login');
                return;
              }
            },
            modelId: widget.modelId,
            model: widget.model,
          ),
          const SizedBox(height: 20),
          const Text("Hələki bir rəy yoxdur."),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewInput(
          onSend: (message, rating) {
            final authState = context.read<AuthBloc>().state;
            if (authState is! Authenticated || authState.user == null) {
              context.go('/login');
              return;
            }

            final user = authState.user!; // backend.UserBase
            final optimisticReview = backend.ReviewsResponse(
              (b) => b
                ..id = DateTime.now().millisecondsSinceEpoch
                ..review = message
                ..rating = rating
                ..createdAt = DateTime.now()
                ..author = (backend.UserOutBuilder()
                  ..id = user.id
                  ..name = user.name
                  ..image = user.image),
            );

            // 🔹 2. UI-ə dərhal əlavə et
            setState(() {
              reviews.insert(0, optimisticReview);
            });
          },
          modelId: widget.modelId,
          model: widget.model,
        ),
        const SizedBox(height: 20),
        ...reviews.map(
          (r) => ReviewCard(
            review: r,
            onDelete: () {
              setState(() {
                reviews.remove(r);
              });
            },
          ),
        ), // 🔹 for əvəzinə spread operator
      ],
    );
  }
}
