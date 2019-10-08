class MovieInfoResponse {
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

  MovieInfoResponse(
    this.actor,
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
    this.reservationRate,
  );

  MovieInfoResponse.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['actor'] = actor;
    map['date'] = date;
    map['director'] = director;
    map['audience'] = audience;
    map['user_rating'] = userRating;
    map['id'] = id;
    map['reservation_grade'] = reservationGrade;
    map['grade'] = grade;
    map['title'] = title;
    map['genre'] = genre;
    map['image'] = image;
    map['duration'] = duration;
    map['synopsis'] = synopsis;
    map['reservation_rate'] = reservationRate;
    return map;
  }
}
