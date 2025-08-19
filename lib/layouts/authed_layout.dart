import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safatapp/services/auth/authbloc.dart';
import 'package:safatapp/services/auth/authstate.dart';

class AuthedLayout extends StatefulWidget {
  final Widget child;

  const AuthedLayout({super.key, required this.child});

  @override
  State<AuthedLayout> createState() => _AuthedLayoutState();
}

class _AuthedLayoutState extends State<AuthedLayout> {
  bool isDoctor = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return widget.child;
        } else if (state is Unauthenticated) {
          return const Center(
            child: Text(
              'Siz daxil olmamısınız',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
