import 'package:flutter/material.dart';

class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ekranın tam eni
      height: 120, // Klassik reklam hündürlüyü
      color: const Color.fromARGB(255, 131, 131, 131), // Boz rəngli fon
      alignment: Alignment.center,
      child: const Text(
        'Reklam',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
