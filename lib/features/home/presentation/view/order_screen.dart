import 'package:flutter/material.dart';

import '../../../../core/color/app_colors.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Not Find any  Order Now ",
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Icon(Icons.rocket_launch, size: 60, color: Colors.blue),
        ],
      ),
    );
  }
}
