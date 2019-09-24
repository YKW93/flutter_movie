import 'package:flutter/material.dart';
import 'package:flutter_movie/model/remote/Movie.dart';

class GridPage extends StatefulWidget {

  List<Movies> _items;

  GridPage(this._items);

  @override
  _GridPageState createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {

  List<Movies> _items;

  _GridPageState(this._items);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('grid'),
    );
  }
}
