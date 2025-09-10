import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:go_router/go_router.dart';
import 'package:safatapp/services/api.dart';

class DoctorCategoriesWidget extends StatefulWidget {
  const DoctorCategoriesWidget({super.key});

  @override
  State<DoctorCategoriesWidget> createState() => _DoctorCategoriesWidgetState();
}

class _DoctorCategoriesWidgetState extends State<DoctorCategoriesWidget> {
  List<backend.DoctorCategoryResponse> categories = [];
  bool loading = true;
  late final backend.Openapi api;

  @override
  void initState() {
    super.initState();
    api = ApiService().api;
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await api
          .getDoctorCategoriesApi()
          .getAllApiAdminDoctorCategoriesGet();

      final List<backend.DoctorCategoryResponse> fetchedCategories =
          response.data?.toList() ?? [];

      setState(() {
        categories = fetchedCategories;
        loading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const CircularProgressIndicator();

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () =>
                context.go('/category/${category.id}/${category.title}'),
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 40,
                      width: 60,
                      child: SvgPicture.network(
                        category.image?.anyOf.values.entries.first.value
                                .toString() ??
                            '',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category.title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
