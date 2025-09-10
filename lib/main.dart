import 'package:flutter/material.dart';
import 'package:safatapp/components/analyzes_doctor.dart';
import 'package:safatapp/layouts/analyzes_layout.dart';
import 'package:safatapp/layouts/authed_layout.dart';
import 'package:safatapp/layouts/main_layout.dart';
import 'package:safatapp/pages/abouts.dart';
import 'package:safatapp/pages/aichat.dart';
import 'package:safatapp/pages/analyzes_clinic.dart';
import 'package:safatapp/pages/appointment_cancel.dart';
import 'package:safatapp/pages/appointment_cancelled.dart';
import 'package:safatapp/pages/appointment_reason.dart';
import 'package:safatapp/pages/blog.dart';
import 'package:safatapp/pages/blogdetail.dart';
import 'package:safatapp/pages/chat.dart';
import 'package:safatapp/pages/chats.dart';
import 'package:safatapp/pages/clinic_detail.dart';
import 'package:safatapp/pages/clinics.dart';
import 'package:safatapp/pages/contact.dart';
import 'package:safatapp/pages/doctor_appointment.dart';
import 'package:safatapp/pages/doctor_appointment_form.dart';
import 'package:safatapp/pages/doctor_category.dart';
import 'package:safatapp/pages/doctor_detail.dart';
import 'package:safatapp/pages/doctors.dart';
import 'package:safatapp/pages/favorites.dart';
import 'package:safatapp/pages/forgot-password.dart';
import 'package:safatapp/pages/home.dart';
import 'package:safatapp/pages/notifications.dart';
import 'package:safatapp/pages/otp.dart';
import 'package:safatapp/pages/pharmacies.dart';
import 'package:safatapp/pages/pharmacy_detail.dart';
import 'package:safatapp/pages/products.dart';
import 'package:safatapp/pages/profile.dart';
import 'package:safatapp/pages/register.dart';
import 'package:safatapp/pages/reset_password.dart';
import 'package:safatapp/pages/rezervation_customer.dart';
import 'package:safatapp/pages/successfull_rezervation.dart';
import 'package:safatapp/services/auth/authevent.dart';
import "pages/login.dart";
import 'package:toastification/toastification.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safatapp/services/auth/authbloc.dart';
import 'package:safatapp/pages/profile_edit.dart';
import 'package:safatapp/services/appointment/appointment_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authBloc = AuthBloc()..add(AuthCheck());
  final appointmentBloc = AppointmentBloc();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => authBloc),
        BlocProvider<AppointmentBloc>(create: (context) => appointmentBloc),
      ],
      child: ToastificationWrapper(child: const MyApp()),
    ),
  );
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

              ShellRoute(
                builder: (context, state, child) => AuthedLayout(child: child),
                routes: [
                  ShellRoute(
                    builder: (context, state, child) =>
                        AnalyzesLayout(child: child),
                    routes: [
                      GoRoute(
                        path: '/analyzes-doctor',
                        builder: (context, state) => const AnalyzesDoctor(),
                      ),
                      GoRoute(
                        path: '/analyzes-clinic',
                        builder: (context, state) => const AnalyzesClinic(),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/profile',
                    builder: (context, state) => const Profile(),
                  ),
                  GoRoute(
                    path: '/rezerves-customer',
                    builder: (context, state) => RezervationCustomer(),
                  ),
                  GoRoute(
                    path: '/notifications',
                    builder: (context, state) => const Notifications(),
                  ),
                  GoRoute(
                    path: '/chat/:id',
                    builder: (context, state) =>
                        ChatScreen(id: state.pathParameters['id']!),
                  ),
                  GoRoute(
                    path: '/ai-chat',
                    builder: (context, state) => const AiChatScreen(),
                  ),
                  GoRoute(
                    path: '/chats',
                    builder: (context, state) => const ChatsListPage(),
                  ),
                  GoRoute(
                    path: '/favorites',
                    builder: (context, state) => const FavoritesPage(),
                  ),
                  GoRoute(
                    path: '/profile-edit',
                    builder: (context, state) => const ProfileEdit(),
                  ),
                  GoRoute(
                    path: '/appointment-cancelled',
                    builder: (context, state) => const AppointmentCancelled(),
                  ),
                  GoRoute(
                    path: '/appointment-cancel/:id',
                    builder: (context, state) =>
                        AppointmentCancel(id: state.pathParameters['id']!),
                  ),
                  GoRoute(
                    path: '/appointment-reason/:id',
                    builder: (context, state) =>
                        AppointmentReason(id: state.pathParameters['id']!),
                  ),
                ],
              ),

              GoRoute(
                path: '/appointment-cancelled',
                builder: (context, state) => const AppointmentCancelled(),
              ),
              GoRoute(
                path: '/appointment-cancel/:id',
                builder: (context, state) =>
                    AppointmentCancel(id: state.pathParameters['id']!),
              ),
              GoRoute(
                path: '/profile-edit',
                builder: (context, state) => const ProfileEdit(),
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
                path: '/shop/:id',
                builder: (context, state) => ProductsListPage(
                  pharmacyId: int.parse(state.pathParameters['id']!),
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
                path: '/doctor-appointment/:id',
                builder: (context, state) => DoctorAppointmentPage(
                  modelId: int.parse(state.pathParameters['id']!),
                ),
              ),
              GoRoute(
                path: '/doctor-appointment-form/:id',
                builder: (context, state) => DoctorAppointmentScreen(
                  modelId: int.parse(state.pathParameters['id']!),
                ),
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
          GoRoute(
            path: '/register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: '/forgot-password',
            builder: (context, state) => const ForgotPasswordPage(),
          ),

          GoRoute(
            path: '/otp/:email',
            builder: (context, state) =>
                OtpPage(email: state.pathParameters['email']!),
          ),
          GoRoute(
            path: '/successfull-rezervation',
            builder: (context, state) => const SuccessfullRezervation(),
          ),
          GoRoute(
            path: '/reset-password/:email/:otp',
            builder: (context, state) => PasswordResetPage(
              email: state.pathParameters['email']!,
              otp: state.pathParameters['otp']!,
            ),
          ),
        ],
      ),
    );
  }
}
