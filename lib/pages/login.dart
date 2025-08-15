import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safatapp/components/LoginForm.dart';
import 'package:safatapp/components/social_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> loginButtons = [
      {
        'label': 'Google ile daxil olun',
        'color': const Color.fromARGB(210, 234, 239, 245),
        'icon': 'Google',
      },
      {
        'label': 'Facebook ile daxil olun',
        'color': const Color.fromARGB(210, 234, 239, 245),
        'icon': 'Facebook',
      },
      {
        'label': 'Apple ile daxil olun',
        'color': const Color.fromARGB(210, 234, 239, 245),
        'icon': 'Apple',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => context.go('/'),
                        child: Image.asset('assets/logo.png'),
                      ),
                      const SizedBox(height: 20),
                      LoginForm(),
                      const Spacer(),
                      Row(
                        children: const <Widget>[
                          Expanded(child: Divider(thickness: 1)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text("və ya"),
                          ),
                          Expanded(child: Divider(thickness: 1)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SocialLogin(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Hesabınız yoxdur?",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(width: 2),
                          TextButton(
                            onPressed: () => context.go('/register'),
                            child: Text(
                              "Qeydiyyatdan keç",
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
