import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  CategoryIcon({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.pink[50],
            child: Icon(icon, color: Colors.black),
          ),
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
