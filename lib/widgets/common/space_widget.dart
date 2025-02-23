import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double space;
  final Axis axis;

  const Space({
    super.key,
    required this.space,
    this.axis = Axis.vertical, // Default to vertical space
  });

  @override
  Widget build(BuildContext context) {
    // Depending on the axis, return either a SizedBox with height or width
    return axis == Axis.vertical
        ? SizedBox(height: space)
        : SizedBox(width: space);
  }
}
