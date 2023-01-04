import 'package:flutter/material.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // disable back button
      child: const Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('RequestsPage'),
          ),
        ),
      ),
    );
  }
}
