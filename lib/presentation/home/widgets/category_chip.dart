import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.iconAsset,
    required this.color,
    required this.onTap,
    this.isSelected = false,
  });

  final String label;
  final String iconAsset;
  final Color color;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isSelected ? 1 : 0.85,
        child: Container(
          height: 39,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(21),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F2E2E4F),
                offset: Offset(0, 6),
                blurRadius: 20,
              ),
            ],
            border: isSelected
                ? Border.all(color: Colors.white, width: 2)
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(iconAsset, width: 18, height: 18),
              const SizedBox(width: 8),
              Text(label, style: AppTextStyles.categoryChipLabel),
            ],
          ),
        ),
      ),
    );
  }
}
