import 'package:flutter/material.dart';
import 'package:todo/core/extensions/gap_x_extensions.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/app_textstyles.dart';
import 'package:todo/core/widgets/w_text.dart';

class WTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? fieldName;
  final int? maxLines;
  final int? minLines;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  const WTextField({
    super.key,
    this.controller,
    this.fieldName,
    this.maxLines,
    this.minLines,
    this.radius,
    this.contentPadding,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  State<WTextField> createState() => _WTextFieldState();
}

class _WTextFieldState extends State<WTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.fieldName != null)
          WText(
            widget.fieldName!,
            style: AppStyles.regular.copyWith(color: AppColors.gray900),
          ),
        4.height,
        TextFormField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          decoration: InputDecoration(
            fillColor: AppColors.gray100,
            contentPadding: widget.contentPadding,
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 8),
            ),
          ),
        ),
      ],
    );
  }
}
