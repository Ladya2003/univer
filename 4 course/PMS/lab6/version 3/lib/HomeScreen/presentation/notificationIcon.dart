
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
          Icons.notifications,
        size: 48.0,
      ),
      onPressed: () {
      },
    );
  }
}