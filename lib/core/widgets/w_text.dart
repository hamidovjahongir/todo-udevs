import 'package:flutter/material.dart';
import 'package:todo/core/utils/app_textstyles.dart';

class WText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  const WText(
    this.text, {
    super.key,
    this.style,
    this.align,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??  AppStyles.semiBold,
      textAlign: align ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
