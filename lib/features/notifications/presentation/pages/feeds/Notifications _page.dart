import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // disable back button
      child: Container(
        child: SafeArea(
          child: Center(
            child: Text('Notifications'),
          ),
        ),
      ),
    );
  }
}
