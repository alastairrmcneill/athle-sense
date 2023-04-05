// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:wellness_tracker/support/theme.dart';

class MyWidget extends StatelessWidget {
  final EdgeInsetsGeometry? externalPadding;
  final EdgeInsetsGeometry? internalPadding;
  final double? borderRadius;
  final Widget child;
  const MyWidget({
    Key? key,
    this.externalPadding,
    this.internalPadding,
    this.borderRadius,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: externalPadding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
            color: MyColors.darkCardColor,
          ),
          padding: internalPadding ?? const EdgeInsets.all(10),
          width: double.infinity,
          child: child,
        ));
  }
}
