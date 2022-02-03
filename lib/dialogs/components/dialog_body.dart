import 'package:flutter/material.dart';

class DialogBody extends StatelessWidget {
  final String message;
  const DialogBody(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.message,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade300
            : Colors.grey.shade800,
        fontSize: 16.0,
      ),
    );
  }
}
