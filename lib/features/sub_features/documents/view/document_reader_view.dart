import 'package:flutter/material.dart';

class DocumentReaderView extends StatelessWidget {
  const DocumentReaderView({
    required this.title,
    required this.content,
    super.key,
  });
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(content),
        ),
      ),
    );
  }
}
