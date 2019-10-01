import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_movie/model/remote/MovieInfo.dart';
import 'tab_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  String _id;

  MovieDetailPage(this._id);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState(_id);
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  String _id;

  _MovieDetailPageState(this._id);

  Future<MovieInfo> _getMovieData() async {
    http.Response response =
        await http.get('http://connect-boxoffice.run.goorm.io/movie?id=$_id');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieInfo.fromJson(data);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('영화 상세 화면'),
        ),
        body: _getData());
  }

  FutureBuilder<MovieInfo> _getData() {
    return FutureBuilder<MovieInfo>(
        future: _getMovieData(),
        builder: (BuildContext contet, AsyncSnapshot<MovieInfo> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return TabPage.showLoading();
            default:
              if (snapshot.hasError)
                return Text('Error : ${snapshot.error}');
              else
                return _testWidget(snapshot.data);
          }
        });
  }

  Widget _testWidget(MovieInfo data) {
    // TODO margin padding등 뷰 사용하는 방법 일치화 시키기
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.network(data.image, height: 180),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.title,
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                    Text(
                      '${data.date}개봉',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      '${data.genre}/${data.duration}분',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '예매율',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        '${data.reservationGrade}위 ${data.reservationRate.toString()}%')
                  ],
                ),
                Container(
                  width: 1,
                  height: 50,
                  color: Colors.grey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '평점',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('7,98'),
                    SizedBox(
                      height: 10,
                    ),
                    RatingBarIndicator(
                      rating: data.userRating / 2,
                      itemSize: 20,
                      itemBuilder: (context, index) =>
                          Icon(Icons.star, color: Colors.amber),
                    ),
                  ],
                ),
                Container(
                  width: 1,
                  height: 50,
                  color: Colors.grey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '누적관객수',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('11,676,822')
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              width: double.infinity,
              height: 10,
              color: Colors.grey.shade400,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                '줄거리',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, top: 10, bottom: 5),
              child: Text(
                data.synopsis,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              width: double.infinity,
              height: 10,
              color: Colors.grey.shade400,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                '감독/출연',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, top: 10, bottom: 5),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '감독',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(data.director),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '출연',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(data.actor),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              width: double.infinity,
              height: 10,
              color: Colors.grey.shade400,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '한줄평',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  IconButton(
                    icon: Icon(Icons.create),
                    alignment: Alignment.center,
                    color: Colors.blue,
                    onPressed: () {
                      print('hh');
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
