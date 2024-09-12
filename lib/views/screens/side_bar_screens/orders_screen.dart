

import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  //const DashboardScreen({super.key});
  static const String routeName = "\Orders Screen";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: const Text(
          'Orders Screen',
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}
