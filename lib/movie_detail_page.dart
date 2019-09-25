import 'package:flutter/material.dart';

class MovideDetailPage extends StatefulWidget {
  @override
  _MovideDetailPageState createState() => _MovideDetailPageState();
}

class _MovideDetailPageState extends State<MovideDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('영화 상세 화면'),
      ),
      body: _testWidget(),
    );
  }

  Widget _testWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('예매율'),
                Text('1위 35.5%')
              ],
            ),
            flex: 1),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('평점'),
              Text('7,98'),
              Text('별별별별별'),
            ],
          ),
          flex: 1,
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('누적관객수'),
              Text('11,676,822')
            ],
          ),
          flex: 1,
        ),
      ],
    );
  }
}
