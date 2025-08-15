import 'package:flutter/material.dart';
import 'package:safatapp/components/mainAppbar.dart';
import 'package:safatapp/components/mainbottomnavigation.dart';
import 'package:safatapp/components/mainend_drawer.dart';
import 'package:safatapp/components/tabbar.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final tabs = [
    Icon(Icons.home),
    Icon(Icons.favorite),
    Icon(Icons.info),
    Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: const MainAppBar(),
      body: SafeArea(child: widget.child),
      endDrawer: const MainEndDrawer(),
      bottomNavigationBar: const CustomTabBar(),
    );
  }
}
