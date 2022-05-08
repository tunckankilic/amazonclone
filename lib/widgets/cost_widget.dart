import 'dart:ui';

import 'package:flutter/material.dart';

class CostWidget extends StatelessWidget {
  final Color color;
  final double cost;
  const CostWidget({
    Key? key,
    required this.color,
    required this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "\$",
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontFeatures: [
              FontFeature.superscripts(),
            ],
          ),
        ),
        Text(
          (cost - (cost - cost.toInt())).toStringAsFixed(2),
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
