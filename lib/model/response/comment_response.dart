class CommentResponse {
  String movieId;
  List<Comment> comments;

  CommentResponse(this.movieId, this.comments);

  CommentResponse.fromJson(Map<String, dynamic> json) {
    movieId = json['movie_id'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((comment) {
        comments.add(Comment.fromJson(comment));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['movie_id'] = movieId;
    if (comments != null) {
      map['comments'] = comments.map((comment) => comment.toMap()).toList();
    }
    return map;
  }
}

class Comment {
  double timestamp;
  String id;
  String movieId;
  double rating;
  String contents;
  String writer;

  Comment(
    this.timestamp,
    this.id,
    this.movieId,
    this.rating,
    this.contents,
    this.writer,
  );

  Comment.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    id = json['id'];
    movieId = json['movie_id'];
    rating = json['rating'].toDouble();
    contents = json['contents'];
    writer = json['writer'];
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['timestamp'] = timestamp;
    map['id'] = id;
    map['movie_id'] = movieId;
    map['rating'] = rating;
    map['contents'] = contents;
    map['writer'] = writer;
    return map;
  }
}
