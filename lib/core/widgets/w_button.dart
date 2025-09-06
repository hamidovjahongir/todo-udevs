import 'package:flutter/material.dart';
import 'package:todo/core/utils/app_colors.dart';

class WButton extends StatefulWidget {
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Widget? child;
  final Text? text;
  final void Function()? onTap;

  const WButton({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.color,
    this.radius,
    this.child,
    this.text,
    this.onTap,
  });

  @override
  State<WButton> createState() => _WButtonState();
}

class _WButtonState extends State<WButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(widget.radius ?? 10),
      onTap: widget.onTap,
      child: Ink(
        padding: widget.padding ?? EdgeInsets.all(12),
        width: widget.width ?? MediaQuery.of(context).size.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color ?? AppColors.blue,
          borderRadius: BorderRadius.circular(widget.radius ?? 10),
        ),
        child: widget.text != null ? Center(child: widget.text) : widget.child,
      ),
    );
  }
}
