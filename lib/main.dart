import 'package:flutter/material.dart';
import 'package:sefatapp2/layouts/main_layout.dart';
import 'package:sefatapp2/pages/abouts.dart';
import 'package:sefatapp2/pages/blog.dart';
import 'package:sefatapp2/pages/blogdetail.dart';
import 'package:sefatapp2/pages/clinic_detail.dart';
import 'package:sefatapp2/pages/clinics.dart';
import 'package:sefatapp2/pages/contact.dart';
import 'package:sefatapp2/pages/doctor_category.dart';
import 'package:sefatapp2/pages/doctor_detail.dart';
import 'package:sefatapp2/pages/doctors.dart';
import 'package:sefatapp2/pages/home.dart';
import 'package:sefatapp2/pages/pharmacies.dart';
import 'package:sefatapp2/pages/pharmacy_detail.dart';
import "pages/login.dart";
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'ŞafaTapp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 34, 109, 100),
        ),
      ),

      routerConfig: GoRouter(
        routes: [
          ShellRoute(
            builder: (context, state, child) => MainLayout(child: child),
            routes: [
              GoRoute(path: '/', builder: (context, state) => const HomePage()),
              GoRoute(
                path: '/about',
                builder: (context, state) => const AboutPage(),
              ),
              GoRoute(
                path: '/blog',
                builder: (context, state) => const BlogListPage(),
              ),
              GoRoute(
                path: '/blog/:slug',
                builder: (context, state) =>
                    BlogDetailPage(slug: state.pathParameters['slug']!),
              ),
              GoRoute(
                path: '/doctors',
                builder: (context, state) => const DoctorsListPage(),
              ),
              GoRoute(
                path: "/doctors/:id",
                builder: (context, state) => DoctorDetailPage(
                  id: int.parse(state.pathParameters['id']!),
                ),
              ),
              GoRoute(
                path: '/clinic/:id',
                builder: (context, state) => ClinicDetailPage(
                  id: int.parse(state.pathParameters['id']!),
                ),
              ),
              GoRoute(
                path: '/pharmacy/:id',
                builder: (context, state) => PharmacyDetailPage(
                  id: int.parse(state.pathParameters['id']!),
                ),
              ),
              GoRoute(
                path: '/category/:id/:name',
                builder: (context, state) => DoctorCategoryListPage(
                  id: int.parse(state.pathParameters['id']!),
                  name: state.pathParameters['name']!,
                ),
              ),
              GoRoute(
                path: '/clinics',
                builder: (context, state) => const ClinicsListPage(),
              ),
              GoRoute(
                path: '/pharmacies',
                builder: (context, state) => const PharmaciesListPage(),
              ),
              GoRoute(
                path: '/contact',
                builder: (context, state) => const ContactPage(),
              ),
            ],
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
        ],
      ),
    );
  }
}
