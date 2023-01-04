import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // disable back button
      child: const Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('Profile'),
          ),
        ),
      ),
    );
  }
}
