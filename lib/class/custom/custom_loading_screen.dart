import 'package:flutter/material.dart';

class LoadingScreen {
  static Widget loading_screen({
    required String text,
  }) {
    return Center(
      child: Column(
        children: [
          const CircularProgressIndicator(
            color: Color(0xFF2355FF),
          ), 
          Text(text),
        ],
      ),
    );
  }
}
