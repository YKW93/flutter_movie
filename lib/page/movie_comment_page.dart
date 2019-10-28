import 'package:flutter/material.dart';
import 'package:flutter_movie/widget/star_rating_bar.dart';
import 'package:flutter_movie/model/response/comment_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieCommentPage extends StatefulWidget {
  final String movieTitle;
  final String movieId;

  MovieCommentPage(this.movieTitle, this.movieId);

  @override
  _MovieCommentPageState createState() => _MovieCommentPageState();
}

class _MovieCommentPageState extends State<MovieCommentPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  int _rating = 0;
  String _writer = "";
  String _contents = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('한줄평 작성'),
        actions: <Widget>[
          _buildSubmitButton(),
        ],
      ),
      body: WillPopScope(
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildMovieTitle(),
                _buildUserRating(),
                _buildHorizontalDivider(),
                _buildNickNameInputForm(),
                _buildCommentInputForm()
              ],
            ),
          ),
        ),
        onWillPop: () {
          Navigator.of(context).pop(false);
          return Future.value(false);
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    final sendIcon = Icon(
      Icons.send,
      color: Colors.white,
      size: 25,
    );
    return IconButton(
      icon: sendIcon,
      onPressed: () {
        if (_writer.isEmpty || _contents.isEmpty) {
          _showSnackBar('모든 정보를 입력해주세요.');
        } else {
          _postComment();
        }
      },
    );
  }

  Widget _buildMovieTitle() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        widget.movieTitle,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildUserRating() {
    return Column(
      children: <Widget>[
        StarRatingBar(
          onRatingChanged: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        ),
        Text(_rating.toString())
      ],
    );
  }

  Widget _buildHorizontalDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14, horizontal: 4),
      width: double.infinity,
      height: 10,
      color: Colors.grey.shade400,
    );
  }

  Widget _buildNickNameInputForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        onChanged: (text) => _writer = text,
        maxLines: 1,
        maxLength: 20,
        decoration: InputDecoration(
          hintText: '닉네임을 입력해주세요',
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentInputForm() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
      child: TextFormField(
        onChanged: (text) => _contents = text,
        maxLines: null,
        maxLength: 100,
        decoration: InputDecoration(
          hintText: '한줄평을 작성해주세요',
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(),
          ),
        ),
      ),
    );
  }

  void _postComment() async {
    final currentTime = DateTime.now().millisecondsSinceEpoch.toDouble() / 1000;
    final commentRequest = Comment(
      timestamp: currentTime,
      movieId: widget.movieId,
      rating: _rating.toDouble(),
      contents: _contents,
      writer: _writer,
    );
    final response = await http.post(
        'http://connect-boxoffice.run.goorm.io/comment',
        body: json.encode(commentRequest.toMap()));
    if (response.statusCode == 200) {
      Navigator.of(context).pop(true);
    } else {
      _showSnackBar('잠시 후 다시 시도해주세요.');
    }
  }

  void _showSnackBar(String text) {
    final snackBar = SnackBar(content: Text(text));
    scaffoldState.currentState.showSnackBar(snackBar);
  }
}
