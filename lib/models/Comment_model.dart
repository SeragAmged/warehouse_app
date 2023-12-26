class Comment {
  final String userName;
  final String content;
  final String userId;

  Comment({required this.userName, required this.content, required this.userId});
}

// Sample comments list (replace this with your API data)
List<Comment> comments = [
  Comment(userName: "User1", content: "Comment 1", userId: "1"),
  Comment(userName: "User2", content: "Comment 2", userId: "2"),
];