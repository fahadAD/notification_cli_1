import 'package:flutter/material.dart';
class MSG_Screen extends StatefulWidget {
  const MSG_Screen({super.key});

  @override
  State<MSG_Screen> createState() => _MSG_ScreenState();
}

class _MSG_ScreenState extends State<MSG_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("msg")),
      body: Column(
        children: [

        ],
      ),
    );
  }
}

