import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

class CertificateCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final dynamic certificate; // File, URL String, or null
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final ThemeData theme;

  const CertificateCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.certificate,
    required this.onTap,
    required this.onRemove,
    required this.theme,
  });

  @override
  State<CertificateCard> createState() => _CertificateCardState();
}

class _CertificateCardState extends State<CertificateCard> {
  String? _cachedPdfPath;
  bool _isDownloading = false;
  String? _downloadError;
  PdfDocument? _pdfDocument;
  bool _pdfLoadError = false;

  @override
  void initState() {
    super.initState();
    _initializePdf();
  }

  @override
  void didUpdateWidget(CertificateCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset cache if certificate changed
    if (oldWidget.certificate != widget.certificate) {
      Logger.log(" ===> Certificate changed, resetting cache ${widget.title}");

      // Dispose of old PDF safely
      _pdfDocument?.close().catchError((e) {
        Logger.log("Error closing old PDF: $e");
      });

      setState(() {
        _cachedPdfPath = null;
        _downloadError = null;
        _pdfDocument = null;
        _pdfLoadError = false;
      });

      // Initialize the new one AFTER resetting
      Future.microtask(() => _initializePdf());
    }
  }

  @override
  void dispose() {
    Future.microtask(() async {
      try {
        if (_pdfDocument != null) {
          await _pdfDocument!.close();
        }
      } catch (error) {
        Logger.log('Error closing PDF document: $error');
      }
    });

    super.dispose();
  }

  void _initializePdf() async {
    Logger.log(" ===> Initializing PDF for ${widget.title}");
    // Small delay to ensure widget is properly initialized
    await Future.delayed(const Duration(milliseconds: 50));
    if (!mounted) return;

    if (widget.certificate is File) {
      File file = widget.certificate as File;
      if (file.path.toLowerCase().endsWith('.pdf')) {
        await _loadPdfDocument(file.path);
      }
    } else if (widget.certificate is String) {
      String url = widget.certificate as String;
      if (_isPdfUrl(url)) {
        _downloadPdfAsync(url);
      }
    }
  }

  Future<void> _loadPdfDocument(String filePath) async {
    try {
      Logger.log(
        " ===> Loading PDF document from $filePath --> ${widget.title}",
      );
      final doc = await PdfDocument.openFile(filePath);
      if (mounted) {
        setState(() {
          _pdfDocument = doc;
          _pdfLoadError = false;
        });
      }
    } catch (e) {
      Logger.log('Error loading PDF document: $e');
      if (mounted) {
        setState(() {
          _pdfLoadError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.certificate != null
              ? widget.theme.primaryColor.withOpacity(0.5)
              : Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          _buildHeader(),
          // Content (Image, PDF, or Upload Placeholder)
          Padding(
            padding: const EdgeInsets.all(16),
            child: widget.certificate == null
                ? _buildUploadPlaceholder()
                : _buildCertificatePreview(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.theme.primaryColor.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              widget.icon,
              color: widget.theme.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: widget.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: widget.theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: widget.theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificatePreview() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _generatePreviewWidget(),
        ),
        _buildRemoveButton(),
        _buildSuccessBadge(),
        // Add tap overlay to allow updating
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _generatePreviewWidget() {
    // Handle File (from local device)
    if (widget.certificate is File) {
      return _buildLocalFilePreview(widget.certificate as File);
    }

    // Handle String URL
    if (widget.certificate is String) {
      String url = widget.certificate as String;

      // Check if it's a PDF URL
      if (_isPdfUrl(url)) {
        return _buildPdfFromUrl(url);
      } else {
        // It's an image URL
        return _buildImagePreview(url, isNetwork: true);
      }
    }

    // Fallback
    return _buildErrorPlaceholder(
      AppLocalizations.of(context)!.unsupportedFileType,
    );
  }

  bool _isPdfUrl(String url) {
    return url.toLowerCase().endsWith('.pdf') ||
        url.toLowerCase().contains('.pdf?') ||
        url.toLowerCase().contains('pdf');
  }

  Widget _buildLocalFilePreview(File file) {
    String path = file.path.toLowerCase();

    if (path.endsWith('.pdf')) {
      Logger.log("Loading local PDF: ${file.path}");
      // Check if PDF is loaded or has error
      if (_pdfLoadError) {
        return _buildPdfPlaceholder(
          showFileName: true,
          fileName: file.path.split('/').last,
        );
      } else if (_pdfDocument != null) {
        return _buildPdfPreviewFromDocument(_pdfDocument!);
      } else {
        return _buildLoadingPlaceholder(
          AppLocalizations.of(context)!.processingPdf,
        );
      }
    } else {
      // It's an image file
      return _buildImagePreview(file.path, isNetwork: false);
    }
  }

  Widget _buildImagePreview(String source, {required bool isNetwork}) {
    return Container(
      height: 120,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: isNetwork
          ? Image.network(
              source,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildErrorPlaceholder(
                  AppLocalizations.of(context)!.imageLoadFailed,
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                    color: widget.theme.primaryColor,
                  ),
                );
              },
            )
          : Image.file(
              File(source),
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildErrorPlaceholder(
                  AppLocalizations.of(context)!.imageLoadFailed,
                );
              },
            ),
    );
  }

  Widget _buildPdfFromUrl(String url) {
    // If download error occurred, show error
    if (_downloadError != null) {
      return _buildErrorPlaceholder(_downloadError!);
    }

    // If currently downloading, show loading
    if (_isDownloading) {
      return _buildLoadingPlaceholder(
        AppLocalizations.of(context)!.downloadingPdf,
      );
    }

    // If PDF is loaded
    if (_pdfDocument != null) {
      return _buildPdfPreviewFromDocument(_pdfDocument!);
    }

    // If PDF failed to load
    if (_pdfLoadError) {
      return _buildPdfPlaceholder(
        showFileName: true,
        fileName: AppLocalizations.of(context)!.pdfFile,
      );
    }

    // If cached but not loaded yet
    if (_cachedPdfPath != null) {
      return _buildLoadingPlaceholder(
        AppLocalizations.of(context)!.processingPdf,
      );
    }

    // Should not reach here, but return loading as fallback
    return _buildLoadingPlaceholder(
      AppLocalizations.of(context)!.downloadingPdf,
    );
  }

  Future<void> _downloadPdfAsync(String url) async {
    if (_isDownloading || _cachedPdfPath != null) {
      Logger.log("===> cachedPdfPath: $_cachedPdfPath --> ${widget.title}");
      return;
    }

    setState(() {
      _isDownloading = true;
      _downloadError = null;
    });

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to download PDF: ${response.statusCode}');
      }

      final dir = await getTemporaryDirectory();
      final fileName =
          'temp_cert_grad_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(response.bodyBytes);

      if (mounted) {
        setState(() {
          _cachedPdfPath = file.path;
          _isDownloading = false;
        });
        // Now load the PDF document
        await _loadPdfDocument(file.path);
      }
    } catch (e) {
      Logger.log('Error downloading PDF: $e');
      if (mounted) {
        setState(() {
          _downloadError = AppLocalizations.of(context)!.pdfDownloadFailed;
          _isDownloading = false;
        });
      }
    }
  }

  Widget _buildPdfPreviewFromDocument(PdfDocument document) {
    return Container(
      height: 120,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Stack(
        children: [
          // Try to render the first page
          FutureBuilder<PdfPage>(
            future: document.getPage(1),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder(
                  future: snapshot.data!.render(
                    width: snapshot.data!.width * 2,
                    height: snapshot.data!.height * 2,
                  ),
                  builder: (context, imageSnapshot) {
                    if (imageSnapshot.hasData) {
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        try {
                          await snapshot.data?.close();
                        } catch (e) {
                          Logger.log("⚠️ Page already closed or invalid: $e");
                        }
                      });
                      return Image.memory(
                        imageSnapshot.data!.bytes,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 120,
                      );
                    }
                    return _buildPdfPlaceholder();
                  },
                );
              }
              return _buildPdfPlaceholder();
            },
          ),
          // PDF overlay indicator
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.white,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    AppLocalizations.of(context)!.pdfPages(document.pagesCount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingPlaceholder(String message) {
    return Container(
      height: 120,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: widget.theme.primaryColor),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfPlaceholder({bool showFileName = false, String? fileName}) {
    return Container(
      height: 120,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.picture_as_pdf, size: 48, color: Colors.red.shade700),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.pdfFile,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (showFileName && fileName != null) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                fileName,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorPlaceholder(String message) {
    return Container(
      height: 120,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              message,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadPlaceholder() {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(12),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [8, 4],
        color: widget.theme.primaryColor.withOpacity(0.5),
        strokeWidth: 2,
        child: Container(
          height: 120,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 40,
                color: widget.theme.primaryColor.withOpacity(0.7),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.clickToUpload,
                style: widget.theme.textTheme.bodyMedium?.copyWith(
                  color: widget.theme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppLocalizations.of(context)!.fileTypes,
                style: widget.theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemoveButton() {
    return Positioned(
      top: 8,
      right: 8,
      child: InkWell(
        onTap: widget.onRemove,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
              ),
            ],
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  Widget _buildSuccessBadge() {
    return Positioned(
      bottom: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              AppLocalizations.of(context)!.uploaded,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
