import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final canPop = GoRouter.of(context).canPop();
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0xFFE5E5E5),

        automaticallyImplyLeading: false,
        leading: GoRouter.of(context).state.path != '/'
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => canPop ? context.pop() : context.go('/'),
              )
            : null,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: LayoutBuilder(
          builder: (context, constraints) {
            final hasLeading = GoRouter.of(context).state.path != '/';
            return hasLeading
                ? Center(
                    // Geri butonu varsa, logo tam ortada
                    child: GestureDetector(
                      onTap: () => context.go('/'),
                      child: Image.asset('assets/logo.png', height: 40),
                    ),
                  )
                : Align(
                    // Geri butonu yoksa, sola dayalı (space-between gibi)
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => context.go('/'),
                      child: Image.asset('assets/logo.png', height: 40),
                    ),
                  );
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, size: 40),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Stack(
          children: [
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.info), label: ''),
              ],
              currentIndex: _getSelectedIndex(context),
              onTap: (index) {
                final location = GoRouter.of(context).state.path;
                if (index == 0 && location != '/') {
                  context.push('/');
                } else if (index == 1 && location != '/about') {
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
                        alignment: _getSelectedIndex(context) == 0
                            ? Alignment.centerLeft
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
                              width: MediaQuery.of(context).size.width / 2,
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
      ),
      endDrawer: SizedBox(
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
                  child: Image.asset(
                    'assets/logo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
              ),

              ListTile(
                title: const Text('Ana Səhifə'),
                onTap: () {
                  Navigator.pop(context);
                  context.push('/');
                },
              ),
              ListTile(
                title: const Text('Haqqımızda'),
                onTap: () {
                  Navigator.pop(context);
                  context.push('/about');
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
      ),
      body: SafeArea(child: child),
    );
  }
}

int _getSelectedIndex(BuildContext context) {
  final String? location = GoRouter.of(context).state.path;
  switch (location) {
    case '/about':
      return 1;
    default:
      return 0;
  }
}
