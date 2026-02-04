import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Icon? icon;
  final MainAxisAlignment iconAlignment;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.borderRadius,
    this.padding,
    this.icon,
    this.iconAlignment = MainAxisAlignment.center,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor ?? AppColors.primary,
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
          ),
        ),
        child: widget.isLoading
            ? SizedBox(
                height: widget.height * 0.4,
                width: widget.height * 0.4,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.onPrimary,
                  ),
                  strokeWidth: 2,
                ),
              )
            : widget.icon != null
            ? Row(
                mainAxisAlignment: widget.iconAlignment,
                children: [
                  widget.icon!,
                  const SizedBox(width: 8),
                  Text(
                    widget.text,
                    style:
                        widget.textStyle ??
                        TextStyle(
                          color: widget.textColor ?? AppColors.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              )
            : Text(
                widget.text,
                style:
                    widget.textStyle ??
                    TextStyle(
                      color: widget.textColor ?? AppColors.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
      ),
    );
  }
}
