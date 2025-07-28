import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Sound Effects'),
            value: true,
            onChanged: (val) {},
          ),
          SwitchListTile(
            title: const Text('Background Music'),
            value: true,
            onChanged: (val) {},
          ),
          ListTile(
            title: const Text('Difficulty Level'),
            trailing: DropdownButton<String>(
              items: const [
                DropdownMenuItem(value: 'easy', child: Text('Easy')),
                DropdownMenuItem(value: 'medium', child: Text('Medium')),
                DropdownMenuItem(value: 'hard', child: Text('Hard')),
              ],
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}