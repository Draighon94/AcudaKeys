import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartePdfViewer extends ConsumerStatefulWidget {
  const PartePdfViewer({super.key, required this.filePath});

  final String filePath;

  @override
  ConsumerState<PartePdfViewer> createState() {
    return _PartePdfViewer();
  }
}

class _PartePdfViewer extends ConsumerState<PartePdfViewer> {
  // Widget? visualizadorPDF;
  @override
  Widget build(BuildContext context) {
    return PDFView(filePath: widget.filePath, defaultPage: 0);
  }
}
