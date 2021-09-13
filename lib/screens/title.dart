import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {

  final String title;

  const LoginTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 34,
      )
    );
  }
}
