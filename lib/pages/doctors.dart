import 'dart:async';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/doctor_card.dart';
import 'package:safatapp/components/search_input.dart';
import 'package:safatapp/services/api.dart';

class DoctorsListPage extends StatefulWidget {
  const DoctorsListPage({super.key});

  @override
  State<DoctorsListPage> createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  List<backend.DoctorOut> doctors = [];
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
      final response = await api.getDoctorsApi().listDoctorsApiDoctorsGet(
        search: searchQuery.trim().isEmpty ? null : searchQuery,
      );
      setState(() {
        doctors = response.data?.toList() ?? [];
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
          "Həkimlər",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),

        // Burada tüm durumlarda Expanded ile sarmalıyoruz:
        Expanded(
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : doctors.isEmpty
              ? const Center(
                  child: Text(
                    'Həkim tapılmadı',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: doctors.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: MediaQuery.of(context).size.height > 850
                        ? 0.75
                        : 0.6,
                  ),
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return DoctorCard(doctor: doctor);
                  },
                ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
