import 'package:flutter/material.dart';

class DialogHeading extends StatelessWidget {
  final String title;
  const DialogHeading(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title.toUpperCase(),
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        letterSpacing: 0.8,
      ),
    );
  }
}
