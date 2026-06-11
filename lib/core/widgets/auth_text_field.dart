import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hint,
    this.prefixIconAsset,
    this.suffixIconAsset,
    this.obscureText = false,
    this.keyboardType,
  });

  final String hint;
  final String? prefixIconAsset;
  final String? suffixIconAsset;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: [
          if (widget.prefixIconAsset != null) ...[
            const SizedBox(width: 15),
            SvgPicture.asset(
              widget.prefixIconAsset!,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.textHint,
                BlendMode.srcIn,
              ),
            ),
          ],
          Expanded(
            child: TextField(
              obscureText: _obscure,
              keyboardType: widget.keyboardType,
              style: AppTextStyles.body3.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: AppTextStyles.inputHint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                isDense: true,
              ),
            ),
          ),
          if (widget.suffixIconAsset != null)
            GestureDetector(
              onTap: () => setState(() => _obscure = !_obscure),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SvgPicture.asset(
                  widget.suffixIconAsset!,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textHint,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
