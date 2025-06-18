import 'package:flutter/material.dart';

void showAppToast(BuildContext context, String message,
    {Color backgroundColor = Colors.black87,
    IconData icon = Icons.check_circle}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Expanded(child: Text(message, style: TextStyle(color: Colors.white))),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      duration: Duration(seconds: 2),
    ),
  );
}
