import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: 50.0,
                right: 50.0,
                top: 50.0,
              ),
              child: Icon(
                Icons.check_circle_outline_rounded,
                color: Color.fromRGBO(88, 129, 87, 1),
                size: 200,
              ),
            ),
          ),
          Text(
            "Well Done",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text(
            "your operation Done\n waiting to see you again",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          Padding(
            padding:
             EdgeInsets.all(
                50.0),
            child: SizedBox(
              width: double.infinity,
              child: DefaultButton(
                  child: Text(
                    "Browse more items",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                  }),
            ),
          )
        ],
      ),
    );
  }
}
