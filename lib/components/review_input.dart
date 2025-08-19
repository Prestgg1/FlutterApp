import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:safatapp/services/api.dart';
import 'package:openapi/openapi.dart' as backend;

class ReviewInput extends StatefulWidget {
  final void Function(String message, int rating) onSend;
  final String model;
  final int modelId;

  const ReviewInput({
    super.key,
    required this.onSend,
    required this.model,
    required this.modelId,
  });

  @override
  State<ReviewInput> createState() => _ReviewInputState();
}

class _ReviewInputState extends State<ReviewInput> {
  final TextEditingController _controller = TextEditingController();
  final api = ApiService().api;
  bool _isComposing = false;
  bool _showEmojiPicker = false;
  int _rating = 0;

  Future<void> _handleSend() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty || _rating > 0) {
      try {
        await api.getReviewsApi().createReviewApiReviewsModelModelIdPost(
          model: widget.model,
          modelId: widget.modelId,
          reviewCreate: backend.ReviewCreate(
            (b) => b
              ..review = text
              ..rating = _rating,
          ),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Rəy uğurla göndərildi')));
      } catch (e) {
        if (e is DioException) {
          final errorData = e.response?.data;
          final message = (errorData is Map && errorData['detail'] != null)
              ? errorData['detail']
              : 'Server xətası baş verdi';
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Naməlum xəta: ${e.toString()}')),
          );
        }
      }
      widget.onSend(text, _rating);
      _controller.clear();
      setState(() {
        _isComposing = false;
        _rating = 0;
      });
    }
  }

  /* I/flutter ( 2013): *** Request ***
I/flutter ( 2013): uri: https://bimonet.com/api/reviews/doctor/1
I/flutter ( 2013): method: POST
I/flutter ( 2013): responseType: ResponseType.json
I/flutter ( 2013): followRedirects: true
I/flutter ( 2013): persistentConnection: true
I/flutter ( 2013): connectTimeout: null
I/flutter ( 2013): sendTimeout: null
I/flutter ( 2013): receiveTimeout: null
I/flutter ( 2013): receiveDataWhenStatusError: true
I/flutter ( 2013): extra: {secure: [{type: oauth2, name: OAuth2PasswordBearer}]}
I/flutter ( 2013): headers:
I/flutter ( 2013):  Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjJ9.PU5VdpBgL2LqCa0uvp9QrzP7U23K4sYk33zP9b6d27o
I/flutter ( 2013):  content-type: application/json
I/flutter ( 2013): data:
I/flutter ( 2013): {rating: 5, review: ertertertertt}
I/flutter ( 2013): 
I/flutter ( 2013): *** Response ***
I/flutter ( 2013): uri: https://bimonet.com/api/reviews/doctor/1
 */
  void _onEmojiSelected(Category? category, Emoji emoji) {
    _controller.text += emoji.emoji;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    setState(() {
      _isComposing = _controller.text.trim().isNotEmpty;
    });
  }

  Widget _buildRatingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        return IconButton(
          onPressed: () {
            setState(() {
              _rating = starIndex;
            });
          },
          icon: Icon(
            _rating >= starIndex ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRatingStars(), // ⭐⭐⭐⭐⭐ rating hissəsi
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions_outlined),
                      onPressed: () {
                        FocusScope.of(context).unfocus(); // klavyaturanı gizlət
                        setState(() {
                          _showEmojiPicker = !_showEmojiPicker;
                        });
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        minLines: 1,
                        maxLines: 4,
                        onChanged: (text) {
                          setState(() {
                            _isComposing = text.trim().isNotEmpty;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: "Rəy yaz...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
                onPressed: (_isComposing || _rating > 0) ? _handleSend : null,
              ),
            ),
          ],
        ),
        if (_showEmojiPicker)
          SizedBox(
            height: 250,
            child: EmojiPicker(onEmojiSelected: _onEmojiSelected),
          ),
      ],
    );
  }
}
