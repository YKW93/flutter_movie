import 'package:flutter/material.dart';

import 'package:flutter_movie/page/tab_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoxOffice',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: TabPage(),
    );
  }
}
