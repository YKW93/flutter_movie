import 'package:flutter/material.dart';
import 'package:flutter_movie/model/remote/Movie.dart';

class ListPage extends StatefulWidget {

  List<Movies> _items;

  ListPage(this._items);

  @override
  _ListPageState createState() => _ListPageState(_items);
}

class _ListPageState extends State<ListPage> {

  List<Movies> _items;

  _ListPageState(this._items);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createListView(context, _items)
    );
  }

  Widget createListView<Movie>(BuildContext context, List<Movies> items) {
    return ListView.separated(
        padding: EdgeInsets.all(8.0),
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => _buildCardItem(context, items[index]));
  }

  Widget _buildCardItem(BuildContext context, Movies item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.network(
          item.thumb,
          height: 120,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(item.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text('평점 : ${item.userRating}'),
                  SizedBox(width: 10),
                  Text('예매순위 : ${item.reservationGrade}'),
                  SizedBox(width: 10),
                  Text('예매율 : ${item.reservationRate}')
                ],
              ),
              SizedBox(height: 10),
              Text('개봉일 : ${item.date}')
            ],
          ),
        )
      ],
    );
  }
}