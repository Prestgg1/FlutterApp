import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canPop = GoRouter.of(context).canPop();
    final path = GoRouter.of(context).state.path;
    final hasLeading = path != '/';

    return AppBar(
      backgroundColor: const Color(0xFFE5E5E5),
      automaticallyImplyLeading: false,
      leading: hasLeading
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
          return hasLeading
              ? Center(
                  child: GestureDetector(
                    onTap: () => context.go('/'),
                    child: Image.asset('assets/logo.png', height: 40),
                  ),
                )
              : Align(
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
            icon: Image.network(
              'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F821ea9db-ca5a-4d88-9630-fc534e946e90.png',
              width: 27,
              height: 20,
              fit: BoxFit.contain,
            ),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
