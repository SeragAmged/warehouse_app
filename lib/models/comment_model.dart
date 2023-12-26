class Comment {
  final String userName;
  final String content;
  final String date;
  final String userId;

  Comment({required this.userName,required this.date, required this.content, required this.userId});
}

// Sample comments list (replace this with your API data)
List<Comment> comments = [
  Comment(userName: "User1",date: "21 april, 2023", content: "Comment 1", userId: "1"),
  Comment(userName: "User2",date: "23 april, 2023", content: "Comment 2", userId: "2"),
];