import 'package:flutter/material.dart';

import 'package:flutter_movie/model/response/movie_response.dart';
import 'package:flutter_movie/page/movie_detail_page.dart';

class MovieGridPage extends StatelessWidget {
  final List<Movie> movies;

  MovieGridPage(this.movies);

  @override
  Widget build(BuildContext context) {
    return _buildGridView(context);
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (9 / 16),
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) => _buildItem(context, index: index),
    );
  }

  Widget _buildItem(BuildContext context, {@required int index}) {
    final movie = movies[index];
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MovieDetailPage(movies[index].id),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Image.network(
                    movie.thumb,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: _buildGradeImage(movie.grade),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            FittedBox(
              child: Text(
                movie.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
                '${movie.reservationGrade}위(${movie.userRating}) / ${movie.reservationRate}%'),
            SizedBox(height: 8),
            Text('${movie.date}'),
          ],
        ),
      ),
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
