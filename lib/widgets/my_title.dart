import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String title;

  const MyTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }
}
