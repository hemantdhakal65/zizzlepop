import 'package:flutter/material.dart';
import 'package:zizzlepop/utils/logger.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  final VoidCallback onReveal;

  const ImageCard({
    super.key,
    required this.imagePath,
    required this.onReveal,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onReveal,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: _buildImageContent(),
      ),
    );
  }

  Widget _buildImageContent() {
    final pathsToTry = [
      imagePath,
      'assets/images/$imagePath',
      'assets/images/placeholder.jpg'
    ];

    for (final path in pathsToTry) {
      try {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            path,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              Logger.error('Failed to load image: $path');
              return _buildPlaceholder();
            },
          ),
        );
      } catch (e) {
        Logger.error('Image load error for $path: $e');
      }
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image, size: 50, color: Colors.red),
            const SizedBox(height: 10),
            Text(
              'Image not found',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 5),
            Text(
              imagePath,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}