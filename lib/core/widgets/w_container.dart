import 'package:flutter/material.dart';
import 'package:todo/core/utils/app_colors.dart';

class WContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final void Function()? onTap;
  const WContainer({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.color,
    required this.child, this.onTap,
  });

  @override
  State<WContainer> createState() => _WContainerState();
}

class _WContainerState extends State<WContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? MediaQuery.of(context).size.width,
        height: widget.height ?? 50,
        decoration: BoxDecoration(
          color: widget.color ?? AppColors.blue,
          borderRadius: BorderRadius.circular(widget.radius ?? 20),
        ),
        child: widget.child,
      ),
    );
  }
}
