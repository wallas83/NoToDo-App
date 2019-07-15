import 'package:flutter/material.dart';
import 'package:no_to_do_app/model/nodo_item.dart';
import 'package:no_to_do_app/util/database_client.dart';

class NotoDoScrean extends StatefulWidget {
  @override
  _NotoDoScreanState createState() => _NotoDoScreanState();
}

class _NotoDoScreanState extends State<NotoDoScrean> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  var db = new DatabaseHelper();

  void _handleSubmit(String text)async {
      _textEditingController.clear();
      NoDOItem notoItem = new NoDOItem(text, DateTime.now().toIso8601String());
      int savedItemId = await db.saveItem(notoItem);

      print("item saved id: $savedItemId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(),
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

  void _showFormDialog() {
    var alert = new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: "Item",
                  hintText: "eg. Don't buy stuff",
                  icon: new Icon(Icons.note_add)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              _handleSubmit(_textEditingController.text);
              _textEditingController.clear();
            },
            child: Text("Save")),
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("cancel"),
        )
      ],
    );
    showDialog(context: context, builder: (_){
        return alert;
    });
  }


}

