import 'package:flutter/material.dart';
import 'package:zizzlepop/utils/constants.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(color: kPrimaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: Image.asset(kLogoPath, height: 40),
          ),
          const SizedBox(height: 10),
          Text(
            kAppName,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
          ),
          const Text(
            'Fun Learning Games',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}