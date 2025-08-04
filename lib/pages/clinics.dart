import 'dart:async';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:sefatapp2/components/clinic_card.dart';
import 'package:sefatapp2/components/search_input.dart';
import 'package:sefatapp2/services/api.dart';

class ClinicsListPage extends StatefulWidget {
  const ClinicsListPage({super.key});

  @override
  State<ClinicsListPage> createState() => ClinicsListPageState();
}

class ClinicsListPageState extends State<ClinicsListPage> {
  List<backend.ClinicsResponse> clinics = [];
  bool loading = true;
  String searchQuery = '';
  Timer? _debounce;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    fetchClinics(); // ilk boş axtarış
    _searchController = TextEditingController();
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
      fetchClinics();
    });
  }

  Future<void> fetchClinics() async {
    setState(() => loading = true);
    try {
      final api = ApiService().api;
      final response = await api.getClinicsApi().getClinicsApiClinicsGet(
        search: searchQuery.trim().isEmpty ? null : searchQuery,
      );
      setState(() {
        clinics = response.data?.toList() ?? [];
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
          "Klinikalar",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),

        if (loading)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else if (clinics.isEmpty)
          const Expanded(
            child: Center(
              child: Text(
                'Klinika tapılmadı',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          )
        else
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: clinics.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final clinic = clinics[index];
                return ClinicCard(clinic: clinic);
              },
            ),
          ),
      ],
    );
  }
}
