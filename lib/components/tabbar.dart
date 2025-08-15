import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int activeIndex = 0;
  final List<Map<String, String>> tabs = [
    {"active": "assets/icons/home_2.svg", "inactive": "assets/icons/home.svg"},

    {
      "inactive": "assets/icons/tabler_heart.svg",
      "active": "assets/icons/tabler_heart_1.svg",
    },
    {
      "active": "assets/icons/wallet_active.svg",
      "inactive": "assets/icons/wallet.svg",
    },
    {
      "active": "assets/icons/user_active.svg",
      "inactive": "assets/icons/user.svg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouter.of(context).state.path;
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        height: 70,
        padding: const EdgeInsets.only(top: 10),
        color: Colors.white,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => {
                    setState(() => activeIndex = 0),
                    context.go('/'),
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        activeIndex == 0
                            ? tabs[0]["active"]!
                            : tabs[0]["inactive"]!,
                        width: 28,

                        height: 28,
                      ),
                      const SizedBox(height: 4),
                      // Dot göstergesi
                      if (activeIndex == 0)
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFF226C63),
                            shape: BoxShape.circle,
                          ),
                        ),
                      const SizedBox(height: 10), // alt çizgi için boşluk bırak
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () => {
                    setState(() => activeIndex = 1),
                    context.go('/notifications'),
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        color: activeIndex == 1
                            ? const Color(0xFF226C63)
                            : const Color.fromARGB(132, 52, 165, 152),
                        activeIndex == 1
                            ? Icons.notifications
                            : Icons.notifications_outlined,
                        size: 28,
                      ),
                      const SizedBox(height: 4),
                      // Dot göstergesi
                      if (activeIndex == 1)
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFF226C63),
                            shape: BoxShape.circle,
                          ),
                        ),
                      const SizedBox(height: 10), // alt çizgi için boşluk bırak
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () => {
                    setState(() => activeIndex = 2),
                    context.go('/favorites'),
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        activeIndex == 2
                            ? tabs[1]["active"]!
                            : tabs[1]["inactive"]!,
                        width: 28,

                        height: 28,
                      ),
                      const SizedBox(height: 4),
                      // Dot göstergesi
                      if (activeIndex == 2)
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFF226C63),
                            shape: BoxShape.circle,
                          ),
                        ),
                      const SizedBox(height: 10), // alt çizgi için boşluk bırak
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () => {
                    setState(() => activeIndex = 3),
                    context.go('/wallet'),
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        activeIndex == 3
                            ? tabs[2]["active"]!
                            : tabs[2]["inactive"]!,
                        width: 28,

                        height: 28,
                      ),
                      const SizedBox(height: 4),
                      // Dot göstergesi
                      if (activeIndex == 3)
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFF226C63),
                            shape: BoxShape.circle,
                          ),
                        ),
                      const SizedBox(height: 10), // alt çizgi için boşluk bırak
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    setState(() => activeIndex = 4),
                    context.go('/profile'),
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        activeIndex == 4
                            ? tabs[3]["active"]!
                            : tabs[3]["inactive"]!,
                        width: 28,

                        height: 28,
                      ),
                      const SizedBox(height: 4),
                      // Dot göstergesi
                      if (activeIndex == 4)
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFF226C63),
                            shape: BoxShape.circle,
                          ),
                        ),
                      const SizedBox(height: 10), // alt çizgi için boşluk bırak
                    ],
                  ),
                ),
              ],
            ),

            // Animated indicator (alt çizgi)
            AnimatedAlign(
              alignment: Alignment(-1.0 + 2.0 * activeIndex / (tabs.length), 1),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                width: MediaQuery.of(context).size.width / tabs.length - 20,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFF226C63),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
