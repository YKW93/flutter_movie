import 'package:flutter/material.dart';
import 'package:flutter_movie/model/remote/Movie.dart';

class GridPage extends StatefulWidget {
  List<Movies> _items;

  GridPage(this._items);

  @override
  _GridPageState createState() => _GridPageState(_items);
}

class _GridPageState extends State<GridPage> {
  List<Movies> _items;

  _GridPageState(this._items);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(child: _createGrideView(context, _items)),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _createGrideView<Movie>(BuildContext context, List<Movies> items) {
    var size = MediaQuery
        .of(context)
        .size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: (9 / 16)),
        itemBuilder: (context, index) => _buildItem(context, items[index]));
  }

  Widget _buildItem(BuildContext context, Movies item) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          AspectRatio(
            aspectRatio: .8,
            child: Image.network(item.thumb, fit: BoxFit.fill),
          ),
          SizedBox(height: 8),
          Text(item.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${item.reservationGrade}위'),
              Text('(${item.userRating})'),
              SizedBox(width: 5),
              Text('/'),
              SizedBox(width: 5),
              Text('${item.reservationRate}%'),
            ],
          ),
          SizedBox(height: 8),
          Text('${item.date}'),
        ],
      ),
    );
  }
}
