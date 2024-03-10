import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  final int pageIndex;

  const PlaceholderPage(this.pageIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page $pageIndex'),
    );
  }
}