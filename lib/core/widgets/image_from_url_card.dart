import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class ImageFromUrlCard extends StatelessWidget {
  const ImageFromUrlCard({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return const Icon(Icons.image_not_supported_outlined, size: 100);
    }

    try {
      if (imageUrl.toLowerCase().contains('.svg')) {
        return SvgPicture.network(
          imageUrl,
          fit: BoxFit.contain,
          placeholderBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      } else if (imageUrl.toLowerCase().contains('lottie') ||
          imageUrl.toLowerCase().contains('.json')) {
        return Lottie.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error_outline, size: 100);
          },
        );
      } else {
        return Image.network(
          imageUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image_outlined, size: 100);
          },
        );
      }
    } catch (e) {
      return const Icon(Icons.error_outline, size: 100);
    }
  }
}
