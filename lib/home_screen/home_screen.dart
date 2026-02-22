import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> tabsList = [];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: []),
    );
  }
}
