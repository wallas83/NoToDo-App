import 'package:flutter/material.dart';

class NotoDoScrean extends StatefulWidget {
  @override
  _NotoDoScreanState createState() => _NotoDoScreanState();
}

class _NotoDoScreanState extends State<NotoDoScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(


      ),

      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.redAccent,
        tooltip: "Add Item",
        child: new ListTile(
          title: Icon(Icons.add),
        ),
        onPressed: _showFormDialog,
      ),
    );
  }
}

void _showFormDialog () {

}
