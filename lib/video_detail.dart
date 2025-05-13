import 'package:flutter/material.dart';

class VideoDetail extends StatefulWidget {
  final String title;
  final String author;
  final String publishDate;
  final String imagePath;

  const VideoDetail({
    super.key,
    required this.title,
    required this.author,
    required this.publishDate,
    required this.imagePath,
  });

  @override
  State<VideoDetail> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  bool _showControls = false;

  void _setShowControls(bool value) {
    setState(() {
      _showControls = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Video', style: TextStyle(fontWeight: FontWeight.bold)),
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
                widget.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${widget.author} - ${widget.publishDate}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: MouseRegion(
                  onEnter: (_) => _setShowControls(true),
                  onExit: (_) => _setShowControls(false),
                  child: GestureDetector(
                    onTap: () => _setShowControls(!_showControls),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            widget.imagePath,
                            width: 320,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (_showControls) ...[
                          Positioned(
                            left: 16,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
                              onPressed: () {},
                            ),
                          ),
                          Positioned(
                            right: 16,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 28),
                              onPressed: () {},
                            ),
                          ),
                          const Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              child: LinearProgressIndicator(
                                value: 0.3,
                                backgroundColor: Colors.white38,
                                color: Color(0xFF1565C0),
                              ),
                            ),
                          ),
                        ],
                        const Icon(
                          Icons.play_circle_fill,
                          size: 64,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
