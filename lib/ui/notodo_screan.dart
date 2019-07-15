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
  final List<NoDOItem> _itemList = <NoDOItem>[];


  @override
  void initState() {
    super.initState();

    _readNoDoList();
  }

  void _handleSubmitted(String text)async {
      _textEditingController.clear();
      NoDOItem notoItem = new NoDOItem(text, DateTime.now().toIso8601String());
      int savedItemId = await db.saveItem(notoItem);

      NoDOItem addedItem = await db.getItem(savedItemId);

      setState(() {
        _itemList.insert(0, addedItem);
      });

      print("item saved id: $savedItemId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: new  Column(
        children: <Widget>[
          new Flexible(

            child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: false,
            itemCount: _itemList.length,
            itemBuilder: (_, int index){
              return  new Card(
                color: Colors.white10,
                child: new ListTile(
                  title: _itemList[index],
                  onLongPress: ()=> debugPrint(""),
                  trailing: new Listener(
                    key: new Key(_itemList[index].itemName),
                    child: new Icon(Icons.remove_circle,
                    color: Colors.redAccent,),
                    onPointerDown: (pointerEvent) => _delateNodo(_itemList[index].id, index),
                  ),
                ),
              );
            })

          ),
          new Divider(
          height: 1.0,
          )
        ],
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
              _handleSubmitted(_textEditingController.text);
              _textEditingController.clear();
              Navigator.pop(context);
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

  _readNoDoList() async {
    List items = await db.getItems();
    items.forEach((item){
      NoDOItem noDOItem = NoDOItem.fromMap(item);
        
      setState(() {
        _itemList.add(NoDOItem.map(item));
      });
    
     });
  }

  _delateNodo(int id, int index) async {
    debugPrint("Delete Item !");
    
    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }

}

