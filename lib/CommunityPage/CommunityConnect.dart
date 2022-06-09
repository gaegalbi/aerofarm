class Post {
  final String category;
  final String title;
  final String contents;

  Post({required this.category, required this.title, required this.contents});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      category: json['userId'],
      title: json['title'],
      contents: json['body'],
    );
  }
}