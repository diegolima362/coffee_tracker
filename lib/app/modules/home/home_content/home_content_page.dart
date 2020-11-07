import 'package:flutter/material.dart';

class HomeContentPage extends StatefulWidget {
  final String title;

  const HomeContentPage({Key key, this.title = "HomeContent"})
      : super(key: key);

  @override
  _HomeContentPageState createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
