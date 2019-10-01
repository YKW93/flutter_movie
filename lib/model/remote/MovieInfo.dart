class MovieInfo {
  String actor;
  String date;
  String director;
  int audience;
  double userRating;
  String id;
  int reservationGrade;
  int grade;
  String title;
  String genre;
  String image;
  int duration;
  String synopsis;
  double reservationRate;

  MovieInfo(
      {this.actor,
        this.date,
        this.director,
        this.audience,
        this.userRating,
        this.id,
        this.reservationGrade,
        this.grade,
        this.title,
        this.genre,
        this.image,
        this.duration,
        this.synopsis,
        this.reservationRate});

  MovieInfo.fromJson(Map<String, dynamic> json) {
    actor = json['actor'];
    date = json['date'];
    director = json['director'];
    audience = json['audience'];
    userRating = json['user_rating'];
    id = json['id'];
    reservationGrade = json['reservation_grade'];
    grade = json['grade'];
    title = json['title'];
    genre = json['genre'];
    image = json['image'];
    duration = json['duration'];
    synopsis = json['synopsis'];
    reservationRate = json['reservation_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actor'] = this.actor;
    data['date'] = this.date;
    data['director'] = this.director;
    data['audience'] = this.audience;
    data['user_rating'] = this.userRating;
    data['id'] = this.id;
    data['reservation_grade'] = this.reservationGrade;
    data['grade'] = this.grade;
    data['title'] = this.title;
    data['genre'] = this.genre;
    data['image'] = this.image;
    data['duration'] = this.duration;
    data['synopsis'] = this.synopsis;
    data['reservation_rate'] = this.reservationRate;
    return data;
  }
}