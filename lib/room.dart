import 'package:flutter/material.dart';

class Room extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title:Text("title")),
     body: Container(child: Text("Hello world"),),
    );
  }
}