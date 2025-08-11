import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/services/api.dart';

class BlogDetailPage extends StatefulWidget {
  final String slug;

  const BlogDetailPage({super.key, required this.slug});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  backend.BlogResponse? blog;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchBlog();
  }

  Future<void> fetchBlog() async {
    try {
      final api = ApiService().api;
      final response = await api.getBlogsApi().getBlogApiBlogsSlugGet(
        slug: widget.slug,
      );

      setState(() {
        blog = response.data;
        loading = false;
      });
    } catch (e) {
      print('Xəta: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : blog == null
          ? const Center(child: Text('Blog tapılmadı'))
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
                        blog!.image?.anyOf.values.entries.first.value
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
                    Text(
                      blog!.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      blog!.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(height: 32),
                    Text(blog!.text, style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
    );
  }
}
