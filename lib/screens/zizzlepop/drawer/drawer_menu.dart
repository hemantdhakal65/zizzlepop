import 'package:flutter/material.dart';
import 'package:zizzlepop/screens/zizzlepop/drawer/drawer_header.dart';
import 'package:zizzlepop/screens/zizzlepop/drawer/drawer_items.dart';
import 'package:zizzlepop/utils/drawer_utils.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeaderWidget(),
          ...DrawerItems.all.map((item) => ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: () => handleDrawerItemClick(context, item),
          )),
        ],
      ),
    );
  }
}