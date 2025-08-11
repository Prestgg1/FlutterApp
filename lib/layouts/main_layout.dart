import 'package:flutter/material.dart';
import 'package:safatapp/components/mainAppbar.dart';
import 'package:safatapp/components/mainbottomnavigation.dart';
import 'package:safatapp/components/mainend_drawer.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: const MainAppBar(),
      bottomNavigationBar: const MainBottomNavigationBar(),
      endDrawer: const MainEndDrawer(),
      body: SafeArea(child: child),
    );
  }
}
