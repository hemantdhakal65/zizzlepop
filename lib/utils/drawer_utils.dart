import 'package:flutter/material.dart';
import 'package:zizzlepop/screens/zizzlepop/drawer/drawer_items.dart';

void handleDrawerItemClick(BuildContext context, DrawerItem item) {
  Navigator.pop(context); // Close drawer

  switch (item) {
    case DrawerItems.home:
      Navigator.pushNamed(context, '/home');
      break;
    case DrawerItems.privacy:
    // Implement navigation
      break;
    case DrawerItems.share:
    // Implement share functionality
      break;
    case DrawerItems.rate:
    // Implement rate app
      break;
    default:
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${item.title} clicked!'))
      );
  }
}