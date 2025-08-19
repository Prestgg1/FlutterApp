import 'dart:async';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/doctor_card.dart';
import 'package:safatapp/components/search_input.dart';
import 'package:safatapp/services/api.dart';

class DoctorCategoryListPage extends StatefulWidget {
  final int id;
  final String name;
  const DoctorCategoryListPage({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  State<DoctorCategoryListPage> createState() => _DoctorCategoryListPageState();
}

class _DoctorCategoryListPageState extends State<DoctorCategoryListPage> {
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
      final response = await api.getDoctorApi().listDoctorsApiDoctorsGet(
        search: searchQuery.trim().isEmpty ? null : searchQuery,
        category: widget.id,
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
          widget.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        if (loading)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else if (doctors.isEmpty)
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
              itemCount: doctors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return DoctorCard(doctor: doctor);
              },
            ),
          ),
      ],
    );
  }
}
