import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';

class MovieCommentPage extends StatefulWidget {
  final movieName;

  MovieCommentPage(this.movieName);

  @override
  _MovieCommentPageState createState() => _MovieCommentPageState();
}

class _MovieCommentPageState extends State<MovieCommentPage> {
  final GlobalKey<ScaffoldState> mScaffoldState = new GlobalKey<ScaffoldState>();
  double _rating = 5;
  String _nickName = "";
  String _comment = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mScaffoldState,
      appBar: AppBar(
        title: Text('한줄평 작성'),
        actions: <Widget>[_buildActionButton()],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildMovieTitle(),
            _buildUserRating(),
            _buildHorizontalDivider(),
            _buildNickNameInputForm(),
            _buildCommentInputForm()
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return IconButton(
      icon: Icon(Icons.save_alt, color: Colors.white, size: 25),
      onPressed: () {
        if (_nickName.isEmpty || _comment.isEmpty) {
          final snackBar = SnackBar(content: Text('모든 정보를 입력해주세요.'));
          mScaffoldState.currentState.showSnackBar(snackBar);
        }
        else {
          // TODO 서버로 전송
        }
      },
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
            onRatingChanged: (rating) => setState(() => _rating = rating),
            initialRating: 5,
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            halfFilledIcon: Icons.star_half,
            isHalfAllowed: true,
            filledColor: Colors.amber,
            size: 48,
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

  Widget _buildNickNameInputForm() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        onChanged: (value) => _nickName = value,
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
    );
  }

  Widget _buildCommentInputForm() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
        child: TextFormField(
          onChanged: (value) => _comment = value,
          maxLines: null,
          maxLength: 100,
          decoration: InputDecoration(
              hintText: '한줄평을 작성해주세요',
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(),
              )),
        ),
      ),
    );
  }
}
