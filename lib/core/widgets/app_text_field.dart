import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconAsset,
    this.suffixIconAsset,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixIconAsset;
  final String? suffixIconAsset;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTextStyles.body3),
          const SizedBox(height: 8),
        ],
        Container(
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
              if (widget.prefixIcon != null) ...[
                const SizedBox(width: 15),
                widget.prefixIcon!,
              ],
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: _obscure,
                  keyboardType: widget.keyboardType,
                  style: AppTextStyles.body3
                      .copyWith(color: AppColors.textPrimary),
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
                  onTap: widget.obscureText
                      ? () => setState(() => _obscure = !_obscure)
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SvgPicture.asset(
                      _obscure ? widget.suffixIconAsset! : AppIcons.hidden,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textHint,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              if (widget.suffixIcon != null)
                GestureDetector(
                  onTap: widget.obscureText
                      ? () => setState(() => _obscure = !_obscure)
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: _obscure
                        ? widget.suffixIcon
                        : SvgPicture.asset(
                            AppIcons.hidden,
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
        ),
      ],
    );
  }
}
