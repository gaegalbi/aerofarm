class SendPost{
  late String title;
  late String writer;
  late String category;

  SendPost({
    required this.title,
    required this.writer,
    required this.category,
  });

  factory SendPost.fromJson(Map<String, dynamic> jsonData){
    return SendPost(
      title: jsonData['title'],
      writer: jsonData['writer'],
      category: jsonData['category'],
    );
  }
}