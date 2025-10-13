import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';
import 'package:pov2/config/theme/app_color.dart';
import 'package:pov2/config/theme/app_text.dart';
import 'package:pov2/core/widget/custom_normal_scaffold.dart';
import 'package:pov2/core/widget/custom_progress_indicator.dart';

class CustomPdfViewerPage extends StatefulWidget {
  final String url;
  final String fileName;
  final bool? isFull;

  const CustomPdfViewerPage({
    super.key,
    this.isFull = true,
    required this.url,
    required this.fileName,
  });

  @override
  State<CustomPdfViewerPage> createState() => _CustomPdfViewerPageState();
}

class _CustomPdfViewerPageState extends State<CustomPdfViewerPage> {
  PdfControllerPinch? _pdfController;
  Uint8List? _pdfBytes;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final response = await http.get(Uri.parse(widget.url));
      if (response.statusCode == 200) {
        setState(() {
          _pdfBytes = response.bodyBytes;
          _pdfController = PdfControllerPinch(
            document: PdfDocument.openData(_pdfBytes!),
          );
        });
      } else {
        setState(() {
          _errorMessage = "Gagal download PDF (status ${response.statusCode})";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Error loading PDF: $e";
      });
    }
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    if (_errorMessage != null) {
      return CustomProgressIndicator.showInformation(context, 'Failed to load Document', 'Error');
    }

    if (_pdfBytes == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_pdfController != null) {
      return PdfViewPinch(controller: _pdfController!);
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFull!
        ? CustomNormalScaffold(
      context: context,
      title: Text(widget.fileName, style: AppText.heading2),
      body: _buildBody(),
    )
        : _buildBody();
  }
}
