

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../model/day.dart';
import 'make_pdf.dart';

class PdfPreviewPage extends StatelessWidget {
  final List<Day> days;
  const PdfPreviewPage({Key? key, required this.days}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(days),
      ),
    );
}