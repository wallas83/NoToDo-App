import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDOItem extends StatelessWidget {

  String _itemName;
  String _dataCreated;
  int _id;

  NoDOItem(this._itemName, this._dataCreated);

  NoDOItem.map(dynamic obj){
    this._itemName = obj["itemName"];
    this._dataCreated = obj["dateCreated"];
    this._id = obj["id"];
  }

  String get itemName => _itemName;
  String get dataCreated => _dataCreated;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["itemName"] = _itemName;
    map["dataCreated"] = _dataCreated;
    if(_id != null){
      map["id"] = _id;
    }

    return map;
  }

  NoDOItem.fromMap(Map<String, dynamic> map) {
    this._itemName = map["itemName"];
    this._dataCreated = map["dataCreated"];
    this._id = map["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_itemName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.9
          ),),
          new Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Text("Created on:$_dataCreated",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.5,
              fontStyle: FontStyle.italic
            ),),
          )
        ],

      ),
    );
  }
}