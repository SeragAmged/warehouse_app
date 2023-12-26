import 'package:flutter/material.dart';

class CommentField extends StatefulWidget {
  final TextEditingController commentController;
  final FocusNode commentFocus;
  final VoidCallback submitComment;

   CommentField({
    required Key key,
    required this.commentController,
    required this.commentFocus,
    required this.submitComment,
  }) : super(key: key);

  @override
  _CommentFieldState createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return TextFormField(
          decoration: InputDecoration(
            suffixIcon: widget.commentFocus.hasFocus
                ? Padding(
              padding: const EdgeInsets.only(bottom: 5.0, right: 5),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_circle_right_rounded,
                  size: 40,
                ),
                onPressed: widget.submitComment,
              ),
            )
                : null,
            hintText: "Leave a comment...",
            hintStyle: TextStyle(
              color: Colors.grey[400],
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            fillColor: Colors.grey.shade200,
            filled: false,
          ),
          controller: widget.commentController,
          keyboardType: TextInputType.text,
          cursorColor: Colors.blue, // Change this to your desired cursor color
          focusNode: widget.commentFocus,
          onEditingComplete: () {
            widget.submitComment();
            // Hide the keyboard
            widget.commentFocus.unfocus();
          },
        );
      },
    );
  }

  // Helper method to rebuild the Builder widget
  void rebuild() {
    setState(() {});
  }
}
