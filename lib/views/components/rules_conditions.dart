import 'package:flutter/material.dart';

Widget buildRulesAndConditions() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '• You receive 10 points with your first purchase.',
        style: TextStyle(fontSize: 16),
      ),
      Text(
        '• Points expire after 11 months.',
        style: TextStyle(fontSize: 16),
      ),
      Text(
        '• For each \$5 spent, you receive 250 points.',
        style: TextStyle(fontSize: 16),
      ),
      Text(
        '• Each purchase earns a minimum of 10 points and a maximum of 10,000 points.',
        style: TextStyle(fontSize: 16),
      ),
    ],
  );
}
