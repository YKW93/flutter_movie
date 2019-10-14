import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter_movie/model/response/comment_response.dart';
import 'movie_comment_page.dart';
import 'package:flutter_movie/model/response/movie_info_response.dart';
import 'package:rating_bar/rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  final String movieId;

  MovieDetailPage(this.movieId);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  String _movieTitle = '';
  MovieInfoResponse _movieInfoResponse;
  CommentResponse _commentResponse;
  Comment _userCommentData;

  @override
  void initState() {
    super.initState();
    _requestInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_movieTitle),
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    if (_movieInfoResponse == null && _commentResponse == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            _buildMovieSummary(),
            _buildMovieSynopsis(),
            _buildMovieCast(),
            _buildComment(),
          ],
        ),
      );
    }
  }

  Widget _buildMovieSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.network(_movieInfoResponse.image, height: 180),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _movieInfoResponse.title,
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  '${_movieInfoResponse.date} 개봉',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${_movieInfoResponse.genre} / ${_movieInfoResponse.duration}분',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildReservationRate(),
            _buildVerticalDivider(),
            _buildUserRating(),
            _buildVerticalDivider(),
            _buildAudience(),
          ],
        ),
      ],
    );
  }

  Widget _buildReservationRate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '예매율',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
                '${_movieInfoResponse.reservationGrade}위 ${_movieInfoResponse.reservationRate.toString()}%'),
          ],
        ),
      ],
    );
  }

  Widget _buildUserRating() {
    return Column(
      children: <Widget>[
        Text(
          '평점',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(_movieInfoResponse.userRating.toString()),
        SizedBox(height: 10),
        RatingBar.readOnly(
          initialRating: _movieInfoResponse.userRating / 2.0,
          filledIcon: Icons.star,
          emptyIcon: Icons.star_border,
          halfFilledIcon: Icons.star_half,
          filledColor: Colors.amber,
          isHalfAllowed: true,
          size: 20,
        ),
      ],
    );
  }

  Widget _buildAudience() {
    return Column(
      children: <Widget>[
        Text(
          '누적관객수',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(_movieInfoResponse.audience.toString()),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 50,
      color: Colors.grey,
    );
  }

  Widget _buildMovieSynopsis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16, top: 10, bottom: 5),
          child: Text(_movieInfoResponse.synopsis),
        ),
      ],
    );
  }

  Widget _buildMovieCast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(_movieInfoResponse.director),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Text(
                    '출연',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(_movieInfoResponse.actor),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.create),
                color: Colors.blue,
                onPressed: () {
                  _navigateAndDisplayMovieComment(context);
                },
              )
            ],
          ),
        ),
        _buildListViewForComment()
      ],
    );
  }

  _navigateAndDisplayMovieComment(BuildContext context)  async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieCommentPage(
              _movieInfoResponse.title, _movieInfoResponse.id)),
    );

    if (result != null) {
        _requestInfo();
    }
  }

  Widget _buildListViewForComment() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.all(10.0),
        itemCount: _commentResponse.comments.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemForComment(_commentResponse.comments[index]);
        });
  }

  Widget _buildItemForComment(Comment comment) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.person_pin,
            size: 50.0,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(comment.writer),
                  SizedBox(width: 5),
                  RatingBar.readOnly(
                    initialRating: comment.rating,
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    halfFilledIcon: Icons.star_half,
                    filledColor: Colors.amber,
                    isHalfAllowed: true,
                    size: 20,
                  ),
                ],
              ),
              Text(_convertTimeStampToDataTime(comment.timestamp)),
              SizedBox(height: 5),
              Text(comment.contents)
            ],
          )
        ],
      ),
    );
  }

  String _convertTimeStampToDataTime(double timestamp) {
    var format = DateFormat('yyyy-MM-dd HH:mm:ss');
    return format
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000));
  }

  void _requestInfo() async {
    setState(() {
      _movieInfoResponse = null;
      _commentResponse = null;
    });
    final movieInfoResponse = await _requestMovieInfo();
    final commentResponse = await _requestComments();
    setState(() {
      _movieInfoResponse = movieInfoResponse;
      _commentResponse = commentResponse;
      _movieTitle = movieInfoResponse.title;
    });
  }

  Future<MovieInfoResponse> _requestMovieInfo() async {
    final response = await http.get(
        'http://connect-boxoffice.run.goorm.io/movie?id=${widget.movieId}');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final movieInfoResponse = MovieInfoResponse.fromJson(jsonData);
      return movieInfoResponse;
    }
    return Future.value();
  }

  Future<CommentResponse> _requestComments() async {
    final response = await http.get(
        'http://connect-boxoffice.run.goorm.io/comments?movie_id=${widget.movieId}');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final commentResponse = CommentResponse.fromJson(jsonData);
      return commentResponse;
    }
    return Future.value();
  }
}
