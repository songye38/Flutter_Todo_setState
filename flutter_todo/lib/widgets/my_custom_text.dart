import 'package:flutter/material.dart';

class MyCustomText extends StatelessWidget {
  final String text;
  final Color? color;  

  const MyCustomText({required this.text, this.color,super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        color: color ?? Colors.deepPurple,  // color가 없으면 기본값으로 deepPurple 사용
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
