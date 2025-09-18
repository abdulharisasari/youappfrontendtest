import 'package:flutter/material.dart';

import '../../../core/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "Access Token:\n${Utils.getToken()}",
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
