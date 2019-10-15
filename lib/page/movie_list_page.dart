import 'package:flutter/material.dart';

import 'package:flutter_movie/model/response/movie_response.dart';
import 'package:flutter_movie/page/movie_detail_page.dart';

class MovieListPage extends StatelessWidget {
  final List<Movie> movies;

  MovieListPage(this.movies);

  @override
  Widget build(BuildContext context) {
    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      separatorBuilder: (_, index) => Divider(color: Colors.grey),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: _buildItem(movies[index]),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MovieDetailPage(movies[index].id),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildItem(Movie movie) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(movie.thumb, height: 120),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _buildTextColumn(movie),
          )
        ],
      ),
    );
  }

  Widget _buildTextColumn(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              movie.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            _buildGradeImage(movie.grade),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Text('평점 : ${movie.userRating}'),
            SizedBox(width: 10),
            Text('예매순위 : ${movie.reservationGrade}'),
            SizedBox(width: 10),
            Text('예매율 : ${movie.reservationRate}')
          ],
        ),
        SizedBox(height: 10),
        Text('개봉일 : ${movie.date}')
      ],
    );
  }

  Widget _buildGradeImage(int grade) {
    switch (grade) {
      case 0:
        return Image.asset("asset/ic_allages.png");
      case 12:
        return Image.asset("asset/ic_12.png");
      case 15:
        return Image.asset("asset/ic_15.png");
      case 19:
        return Image.asset("asset/ic_19.png");
      default:
        return null;
    }
  }
}
