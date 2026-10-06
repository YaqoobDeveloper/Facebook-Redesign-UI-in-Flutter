import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Round profile picture loaded from the network, with a fallback icon.
class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.url, this.size = 50});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          width: size,
          height: size,
          color: AppColors.placeholder,
          child: Icon(Icons.person, color: AppColors.muted, size: size * 0.6),
        ),
      ),
    );
  }
}
