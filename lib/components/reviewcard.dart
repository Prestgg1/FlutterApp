import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/services/api.dart';
import 'package:safatapp/services/auth/authbloc.dart';
import 'package:safatapp/services/auth/authstate.dart';
import 'ratingStars.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key, required this.review, required this.onDelete});

  final backend.ReviewsResponse review;
  final VoidCallback onDelete;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  final api = ApiService().api;
  void _onMenuSelected(String value) {
    if (value == 'delete') {
      deleteReview();
    } else if (value == 'report') {
      print("Şikayət pressed");
      // burda şikayət API çağırışı gələ bilər
    }
  }

  Future<void> deleteReview() async {
    try {
      await api.getReviewsApi().deleteReviewApiReviewsReviewIdDelete(
        reviewId: widget.review.id,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Rey silindi')));
      widget.onDelete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.network(
                    widget.review.author.image.toString(),
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 36,
                        height: 36,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.person, size: 24),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.review.author.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RatingStars(rating: widget.review.rating.toDouble()),
                      Text(widget.review.review),
                    ],
                  ),
                ),

                // sağ üst küncdə dropbox menyu
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      final currentUser = state.user;
                      final isOwner =
                          currentUser?.id == widget.review.author.id;

                      return PopupMenuButton<String>(
                        onSelected: _onMenuSelected,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: isOwner ? 'delete' : 'report',
                            child: Text(isOwner ? 'Sil' : 'Şikayət et'),
                          ),
                        ],
                        icon: const Icon(Icons.more_vert),
                      );
                    }
                    return const SizedBox(); // login olmayan üçün menyu yoxdur
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
