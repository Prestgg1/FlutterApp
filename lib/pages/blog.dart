import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/services/api.dart';

class BlogListPage extends StatefulWidget {
  const BlogListPage({super.key});

  @override
  State<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  List<backend.BlogResponse> blogs = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    try {
      final api = ApiService().api;

      final response = await api.getBlogApi().getAllBlogsApiBlogsGet();
      setState(() {
        blogs = (response.data?.toList() ?? []);
        loading = false;
      });
    } catch (e) {
      print('Xəta baş verdi: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              final blog = blogs[index];
              final isEven = index % 2 == 0;
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: isEven
                      ? [
                          _buildImage(blog),
                          const SizedBox(width: 12),
                          _buildContent(blog),
                        ]
                      : [
                          _buildContent(blog),
                          const SizedBox(width: 12),
                          _buildImage(blog),
                        ],
                ),
              );
            },
          );
  }

  Widget _buildImage(backend.BlogResponse blog) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        blog.image!,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 100,
          height: 100,
          color: Colors.grey.shade300,
          child: const Icon(Icons.image_not_supported),
        ),
      ),
    );
  }

  Widget _buildContent(backend.BlogResponse blog) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            blog.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            blog.description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => context.go('/blog/${blog.slug}'),
            child: Text(
              'Read More...   ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
