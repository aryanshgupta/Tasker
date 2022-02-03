import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  const InputField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      keyboardType: this.keyboardType,
      decoration: InputDecoration(
        hintText: "Input here",
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white10
            : Colors.grey.shade100,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),
      ),
      style: TextStyle(
        fontSize: 16.0,
      ),
      maxLines: null,
      maxLength: this.maxLength,
    );
  }
}
