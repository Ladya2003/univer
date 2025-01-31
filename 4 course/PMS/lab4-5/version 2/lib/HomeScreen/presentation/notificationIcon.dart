import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Image.asset(
        'assets/notifications_white_unread.png',
        width: 40,
        height: 40,
      )
    );
  }
}
