import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieCommentPage extends StatefulWidget {
  final movieName;

  MovieCommentPage(this.movieName);

  @override
  _MovieCommentPageState createState() => _MovieCommentPageState();
}

class _MovieCommentPageState extends State<MovieCommentPage> {
  double _rating = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('한줄평 작성'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildMovieTitle(),
            _buildUserRating(),
            _buildHorizontalDivider(),
            _buildCommentInputForm()
          ],
        ),
      ),
    );
  }

  Widget _buildMovieTitle() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        widget.movieName,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildUserRating() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RatingBar(
            initialRating: 5,
            direction: Axis.horizontal,
            glow: false,
            itemSize: 60,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) =>
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          Text(_rating.toString())
        ],
      ),
    );
  }

  Widget _buildHorizontalDivider() {
    return Container(
      margin: EdgeInsets.only(top: 14, bottom: 14, left: 4, right: 4),
      width: double.infinity,
      height: 10,
      color: Colors.grey.shade400,
    );
  }

  Widget _buildCommentInputForm() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: TextFormField(
            maxLines: 1,
            maxLength: 20,
            decoration: InputDecoration(
                hintText: '닉네임을 입력해주세요',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(),
                )),
          ),
        ),
        Expanded(
          child: TextFormField(
            maxLines: 1,
            maxLength: 20,
            decoration: InputDecoration(
                hintText: '닉네임을 입력해주세요',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(),
                )),
          ),
        ),
      ],
    );
  }
}
