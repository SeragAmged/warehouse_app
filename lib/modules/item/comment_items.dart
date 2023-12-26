import 'package:flutter/material.dart';
import 'package:warehouse_app/styles/colors.dart';
import 'package:warehouse_app/styles/icon_broken.dart';

Widget buildCommentItem(List<dynamic> comments, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey.shade100,
              child: Icon(
                IconBroken.profile,
                color: primaryColor,
                size: 20,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "username",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "12 april,2023",
                  style: TextStyle(fontSize: 10, height: 1, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0,top: 8,left: 35),
          child: Text(
            "content goes here . .. sdksjdksjkdjsd ",
            style: TextStyle(fontSize: 12),
          ),
        ),
      ]));
}
