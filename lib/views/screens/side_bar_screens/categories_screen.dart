

import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  //const DashboardScreen({super.key});
  static const String routeName = "\CategoriesScreen";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: const Text(
          'Categories',
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}
