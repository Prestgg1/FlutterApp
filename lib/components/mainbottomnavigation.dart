import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({Key? key}) : super(key: key);

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouter.of(context).state.path;
    switch (location) {
      case '/about':
        return 2;
      case '/favorites':
        return 1;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);

    return SafeArea(
      child: Stack(
        children: [
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.info), label: ''),
            ],
            currentIndex: selectedIndex,
            onTap: (index) {
              final location = GoRouter.of(context).state.path;
              if (index == 0 && location != '/') {
                context.push('/');
              } else if (index == 1 && location != '/favorites') {
                context.push('/favorites');
              } else if (index == 2 && location != '/about') {
                context.push('/about');
              }
            },
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
          Positioned.fill(
            top: null,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 10,
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      alignment: selectedIndex == 0
                          ? Alignment.centerLeft
                          : selectedIndex == 1
                          ? Alignment.center
                          : Alignment.centerRight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
