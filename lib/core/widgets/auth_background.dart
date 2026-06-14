import 'dart:ui';

import 'package:events_hub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ColoredBackground extends StatelessWidget {
  const ColoredBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          const Positioned(
              top: -40, left: -54, child: _Blob(size: 189, opacity: 0.5)),
          const Positioned(
              top: -75, right: -50, child: _Blob(size: 227, opacity: 0.7)),
          const Positioned(
              bottom: 80, left: -107, child: _Blob(size: 189, opacity: 0.4)),
          const Positioned(
              bottom: -30, right: -80, child: _Blob(size: 349, opacity: 0.5)),
          const Positioned(
              top: 280, right: -30, child: _Blob(size: 180, opacity: 0.35)),
          child,
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.blobPurple.withValues(alpha: opacity),
        ),
      ),
    );
  }
}
