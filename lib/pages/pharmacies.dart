import 'dart:async';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:sefatapp2/components/pharmacy_card.dart';
import 'package:sefatapp2/components/search_input.dart';
import 'package:sefatapp2/services/api.dart';

class PharmaciesListPage extends StatefulWidget {
  const PharmaciesListPage({super.key});

  @override
  State<PharmaciesListPage> createState() => PharmaciesListPageState();
}

class PharmaciesListPageState extends State<PharmaciesListPage> {
  List<backend.PharmaciesResponse> pharmacies = [];
  bool loading = true;
  String searchQuery = '';
  Timer? _debounce;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPharmacies(); // ilk boş axtarış
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void onSearchChanged(String query) {
    setState(() => searchQuery = query);
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchPharmacies();
    });
  }

  Future<void> fetchPharmacies() async {
    setState(() => loading = true);
    try {
      final api = ApiService().api;
      final response = await api
          .getPharmaciesApi()
          .getPharmaciesApiPharmaciesGet(
            search: searchQuery.trim().isEmpty ? null : searchQuery,
          );
      setState(() {
        pharmacies = response.data?.toList() ?? [];
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
          "Apteklər",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),

        if (loading)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else if (pharmacies.isEmpty)
          const Expanded(
            child: Center(
              child: Text(
                'Aptek tapılmadı',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          )
        else
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: pharmacies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final pharmacy = pharmacies[index];
                return PharmacyCard(pharmacy: pharmacy);
              },
            ),
          ),
      ],
    );
  }
}
