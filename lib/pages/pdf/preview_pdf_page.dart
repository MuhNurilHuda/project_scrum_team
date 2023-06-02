import 'package:flutter/material.dart';
import 'package:iterasi1/model/itinerary.dart';
import 'package:printing/printing.dart';

import 'make_pdf.dart';

class PdfPreviewPage extends StatelessWidget {
  final Itinerary itinerary;
  const PdfPreviewPage({Key? key, required this.itinerary}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFE5BA73),
          title: const Text('PDF Preview'),
        ),
        body: PdfPreview(
          build: (context) => makePdf(itinerary),
        ),
    );
}