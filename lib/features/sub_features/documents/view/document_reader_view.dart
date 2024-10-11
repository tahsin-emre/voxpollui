import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_app_bar.dart';
import 'package:voxpollui/features/sub_features/documents/data/document_model.dart';

class DocumentReaderView extends StatefulWidget {
  const DocumentReaderView({
    required this.document,
    super.key,
  });
  final DocumentModel document;

  @override
  State<DocumentReaderView> createState() => _DocumentReaderViewState();
}

class _DocumentReaderViewState extends State<DocumentReaderView> {
  String content = '';

  @override
  void initState() {
    super.initState();
    _fetchContent();
  }

  Future<void> _fetchContent() async {
    final text = await rootBundle.loadString(widget.document.path);
    setState(() => content = text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, title: widget.document.title),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Markdown(data: content),
      ),
    );
  }
}
