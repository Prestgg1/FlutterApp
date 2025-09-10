import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safatapp/services/auth/authbloc.dart';
import 'package:safatapp/services/auth/authevent.dart';
import 'package:safatapp/services/auth/authstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainEndDrawer extends StatelessWidget {
  const MainEndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  context.go('/');
                },
                child: Image.asset('assets/logo.png', height: 100, width: 100),
              ),
            ),
            ListTile(
              title: const Text('Analizlər'),
              onTap: () {
                Navigator.pop(context);
                context.push('/analyzes-doctor');
              },
            ),
            /*  ListTile(
              title: const Text('Haqqımızda'),
              onTap: () {
                Navigator.pop(context);
                context.push('/about');
              },
            ), */
            ListTile(
              title: const Text('Rezervasiyalar'),
              onTap: () {
                Navigator.pop(context);
                context.push('/rezerves-customer');
              },
            ),
            ListTile(
              title: const Text('Chat'),
              onTap: () {
                Navigator.pop(context);
                context.push('/chats');
              },
            ),

            ListTile(
              title: const Text('Həkimlər'),
              onTap: () {
                Navigator.pop(context);
                context.push('/doctors');
              },
            ),
            ListTile(
              title: const Text("Aptekler"),
              onTap: () {
                Navigator.pop(context);
                context.push('/pharmacies');
              },
            ),
            ListTile(
              title: const Text("Clinics"),
              onTap: () {
                Navigator.pop(context);
                context.push('/clinics');
              },
            ),
            ListTile(
              title: const Text("Favoritler"),
              onTap: () {
                Navigator.pop(context);
                context.push('/favorites');
              },
            ),

            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return ListTile(
                    title: const Text("Çıxış"),
                    onTap: () {
                      Navigator.pop(context);
                      context.read<AuthBloc>().add(AuthLogout());
                    },
                  );
                } else if (state is Unauthenticated) {
                  return ListTile(
                    title: const Text("Daxil Ol"),
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/login');
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),

            ListTile(
              title: const Text('Blog'),
              onTap: () {
                Navigator.pop(context);
                context.push('/blog');
              },
            ),
            ListTile(
              title: const Text('Əlaqə'),
              onTap: () {
                Navigator.pop(context);
                context.push('/contact');
              },
            ),
          ],
        ),
      ),
    );
  }
}
