import 'package:flutter/material.dart';

import 'notodo_screan.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("NoToDo"),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: new NotoDoScrean(),
    );
  }
}
