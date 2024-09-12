

import 'package:flutter/material.dart';

class VendorsScreen extends StatelessWidget {
  //const DashboardScreen({super.key});
  static const String routeName = "\VendorsScreen";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: const Text(
          'Vendors',
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}
