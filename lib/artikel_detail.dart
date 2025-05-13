import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

class ArtikelDetail extends StatelessWidget {
  final String title;
  final String author;
  final String publishDate;
  final String imagePath;
  final String content;

  const ArtikelDetail({
    super.key,
    required this.title,
    required this.author,
    required this.publishDate,
    required this.imagePath,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = const SizedBox.shrink();
    if (imagePath.isNotEmpty) {
      if (kIsWeb && imagePath.startsWith('blob:')) {
        imageWidget = Image.network(
          imagePath,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        );
      } else if (!kIsWeb && File(imagePath).existsSync()) {
        imageWidget = Image.file(
          File(imagePath),
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        );
      } else {
        imageWidget = Image.asset(
          imagePath,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Artikel', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFF7F8FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$author - $publishDate',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              if (imagePath.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imageWidget,
                )
              else
                Container(
                  width: double.infinity,
                  height: 180,
                  color: Colors.blue[50],
                  child: Center(
                    child: Icon(
                      Icons.recycling,
                      size: 100,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
