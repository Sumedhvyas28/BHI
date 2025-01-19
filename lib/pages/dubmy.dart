import 'package:flutter/material.dart';

class DubmyPage extends StatefulWidget {
  const DubmyPage({super.key});

  @override
  State<DubmyPage> createState() => _DubmyPageState();
}

class _DubmyPageState extends State<DubmyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('dubmy'),
      ),
    );
  }
}
