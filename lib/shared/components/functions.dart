import 'package:flutter/material.dart';
import '../network/local/cache_helper.dart';

void navigateTo(context, pageTo) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => pageTo),
  );
}

void navigateToWithReplacement(context, pageTo) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => pageTo),
    (Route<dynamic> route) => false,
  );
}

void logOut(context) {
  CacheHelper.removeData(key: 'token').then(
    (value) {
      if (value) navigateToWithReplacement(context, const Placeholder());
    },
  );
}