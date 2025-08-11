import 'dart:async';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/product_card.dart';
import 'package:safatapp/components/search_input.dart';
import 'package:safatapp/services/api.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key, required this.pharmacyId});

  final int pharmacyId;

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  List<backend.Product> products = [];
  bool loading = true;
  String searchQuery = '';
  Timer? _debounce;
  late final backend.Openapi api;
  @override
  void initState() {
    super.initState();
    api = ApiService().api;
    fetchDoctors(); // ilk boş axtarış
    _searchController = TextEditingController();
  }

  late final TextEditingController _searchController;

  @override
  void dispose() {
    _searchController.dispose();

    _debounce?.cancel();
    super.dispose();
  }

  void onSearchChanged(String query) {
    setState(() => searchQuery = query);
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchDoctors();
    });
  }

  Future<void> fetchDoctors() async {
    setState(() => loading = true);
    try {
      final response = await api
          .getProductApi()
          .listByPharmacyApiProductPharmacyIdGet(
            pharmacyId: widget.pharmacyId,
            search: searchQuery.trim().isEmpty ? null : searchQuery,
          );
      setState(() {
        products = response.data?.toList() ?? [];
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),

          child: SearchInput(
            controller: _searchController,
            onChanged: onSearchChanged,
          ),
        ),
        Text(
          "Dərmanlar",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),

        if (loading)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else if (products.isEmpty)
          const Expanded(
            child: Center(
              child: Text(
                'Həkim tapılmadı',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          )
        else
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            ),
          ),
      ],
    );
  }
}
