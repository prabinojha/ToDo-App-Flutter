import 'package:flutter/material.dart';

Widget textField(controller, keyboardType, maxLength, maxLines, hintText) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      cursorColor: Colors.grey,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(15),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromRGBO(114, 76, 249, 1),
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromRGBO(2, 43, 58, 0.5),
            width: 2.0,
          ),
        ),
        fillColor: Colors.grey,
        hintStyle: const TextStyle(
          color: Color.fromRGBO(2, 43, 58, 0.4),
        ),
      ),
    ),
  );
}
