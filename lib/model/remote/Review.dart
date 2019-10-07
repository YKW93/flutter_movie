class Review {
  String movieId;
  List<Comments> comments;

  Review({this.movieId, this.comments});

  Review.fromJson(Map<String, dynamic> json) {
    movieId = json['movie_id'];
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movie_id'] = this.movieId;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  double timestamp;
  String id;
  String movieId;
  double rating;
  String contents;
  String writer;

  Comments(
      {this.timestamp,
        this.id,
        this.movieId,
        this.rating,
        this.contents,
        this.writer});

  Comments.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    id = json['id'];
    movieId = json['movie_id'];
    rating = json['rating'].toDouble();
    contents = json['contents'];
    writer = json['writer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['id'] = this.id;
    data['movie_id'] = this.movieId;
    data['rating'] = this.rating;
    data['contents'] = this.contents;
    data['writer'] = this.writer;
    return data;
  }
}