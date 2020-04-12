import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String name;
  final Color color;
  final String iconURL;

  Category(this.name, this.color, this.iconURL);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.network(
          iconURL,
          height: 100,
          width: 100,
        ),
        Text(
          name.toUpperCase(),
          textScaleFactor: 1.5,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ])),
      color: color,
    );
  }
}
