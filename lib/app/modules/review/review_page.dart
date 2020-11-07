import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'review_controller.dart';

class ReviewPage extends StatefulWidget {
  final String title;

  const ReviewPage({Key key, this.title = "Review"}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends ModularState<ReviewPage, ReviewController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
