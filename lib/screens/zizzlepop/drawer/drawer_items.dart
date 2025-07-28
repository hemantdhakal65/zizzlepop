import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final String route;

  const DrawerItem(this.title, this.icon, this.route);
}

class DrawerItems {
  static const home = DrawerItem('Home', Icons.home, '/home');
  static const privacy = DrawerItem('Privacy Policy', Icons.privacy_tip, '/privacy');
  static const share = DrawerItem('Share with Friends', Icons.share, '/share');
  static const rate = DrawerItem('Rate Us', Icons.star, '/rate');
  static const apps = DrawerItem('More Apps', Icons.apps, '/apps');
  static const feedback = DrawerItem('Feedback', Icons.feedback, '/feedback');
  static const howToPlay = DrawerItem('How to Play', Icons.help, '/howtoplay');
  static const about = DrawerItem('About ZizzlePop', Icons.info, '/about');

  static const List<DrawerItem> all = [
    home, privacy, share, rate, apps, feedback, howToPlay, about
  ];
}