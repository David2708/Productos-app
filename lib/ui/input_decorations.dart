import 'package:flutter/material.dart';

class InputDecorations {

  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    required Color color,
    IconData? icon,

  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color),
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color, width: 2)),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      icon: icon != null
          ? Icon(icon, color: color)
          : null
    );
  }
}
