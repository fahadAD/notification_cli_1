import 'package:flutter/material.dart';
class MSG_Screen extends StatefulWidget {
  const MSG_Screen({super.key, required this.id});
final String id;
  @override
  State<MSG_Screen> createState() => _MSG_ScreenState();
}

class _MSG_ScreenState extends State<MSG_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title:   Text("msg"+widget.id)),
      body: Column(
        children: [
             Text("msg ${widget.id}")
        ],
      ),
    );
  }
}

