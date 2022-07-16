import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  var onPressed;
  String title;
  Color color;

  Button({
    Key? key,
    required this.onPressed,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 10, 5),
      child: ElevatedButton(
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
            MediaQuery.of(context).size.width - 35,
            55,
          ),
          elevation: 0,
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
