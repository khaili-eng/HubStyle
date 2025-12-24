import 'package:flutter/material.dart';
import 'package:untitled7/core/routes/routes_app.dart';

class EmptyFavorite extends StatelessWidget {
  const EmptyFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text("Your Favorite Is Empty", style: TextStyle()),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, RoutesApp.home);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Start Add To Favorite",
              style: TextStyle()
            ),
          )

        ],
      ),
    );
  }
}
