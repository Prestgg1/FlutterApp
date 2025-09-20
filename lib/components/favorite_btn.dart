import 'dart:async';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/services/api.dart';
import 'package:toastification/toastification.dart';

class FavoriteBtn extends StatefulWidget {
  FavoriteBtn({
    super.key,
    required this.isFavorite,
    required this.type,
    required this.id,
  });

  bool isFavorite;
  final backend.FavoriteType type;
  final String id;

  @override
  State<FavoriteBtn> createState() => _FavoriteBtnState();
}

class _FavoriteBtnState extends State<FavoriteBtn> {
  final api = ApiService().api;
  Timer? _debounce;

  /// Debounced API çağırışı
  void _scheduleApiCall() {
    _debounce?.cancel(); // köhnəni ləğv edirik

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        if (widget.isFavorite) {
          await api
              .getFavoritesApi()
              .addFavoriteApiFavoritesModelTypeModelIdPost(
                modelId: int.parse(widget.id),
                modelType: widget.type,
              );
        } else {
          await api
              .getFavoritesApi()
              .removeFavoriteApiFavoritesModelTypeModelIdDelete(
                modelId: int.parse(widget.id),
                modelType: widget.type,
              );
        }
      } catch (e) {
        debugPrint("Favorite toggle error: $e");

        // Əgər backend error verərsə UI-ni geri qaytar
        setState(() {
          widget.isFavorite = !widget.isFavorite;
        });
        toastification.show(
          title: Text("Daxil olmalısınız!"),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
    });
  }

  void _toggleFavorite() {
    setState(() {
      widget.isFavorite = !widget.isFavorite;
    });
    _scheduleApiCall();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: _toggleFavorite,
        child: Icon(
          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: widget.isFavorite ? Colors.red : Colors.grey,
        ),
      ),
    );
  }
}
