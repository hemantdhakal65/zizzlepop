import 'package:flutter/material.dart';

class MemoryHome extends StatelessWidget {
  const MemoryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory Mode')),
      body: const Center(child: Text('Memory Mode Home')),
    );
  }
}