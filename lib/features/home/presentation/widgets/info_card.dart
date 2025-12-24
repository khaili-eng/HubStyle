import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key,required this.icon,required this.title,required this.value});
  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ), child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ), title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text(value),
        trailing: Icon(
          Icons.arrow_forward,
          size: 16,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
