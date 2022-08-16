import 'package:flutter/material.dart';

class ListTileWIdget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;

  const ListTileWIdget({
    Key? key,
    required this.icon,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        data,
        style: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontWeight: FontWeight.w300,
        ),
      ),
      leading: Icon(icon),
    );
  }
}
