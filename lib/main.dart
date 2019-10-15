import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_movie/page/tab_page.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

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
