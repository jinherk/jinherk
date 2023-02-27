import 'package:flutter/material.dart';
import 'Middle.dart';

class index0 extends StatefulWidget {
  const index0({Key? key}) : super(key: key);

  @override
  State<index0> createState() => _index0State();
}

class _index0State extends State<index0> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Middle(),
        ],
      ),
    );
  }
}

