import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int _selectedIndex = 0;

  int _getSelectedIndexFromPath(String path) {
    switch (path) {
      case '/about':
        return 2;
      case '/favorites':
        return 1;
      case '/profile-edit':
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    final router = GoRouter.of(context);
    final location = router.state.path;

    setState(() {
      _selectedIndex = index;
    });

    if (index == 0 && location != '/') {
      context.push('/');
    } else if (index == 1 && location != '/favorites') {
      context.push('/favorites');
    } else if (index == 2 && location != '/about') {
      context.push('/about');
    } else if (index == 3 && location != '/profile-edit') {
      context.push('/profile-edit');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Router state dəyişəndə _selectedIndex yenilənir
    final path = GoRouter.of(context).state.path ?? '/';
    _selectedIndex = _getSelectedIndexFromPath(path);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.info), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
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
                      alignment: _selectedIndex == 0
                          ? Alignment.centerLeft
                          : _selectedIndex == 1
                          ? Alignment.center
                          : _selectedIndex == 2
                          ? Alignment.centerRight
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
                            width: MediaQuery.of(context).size.width / 4,
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
