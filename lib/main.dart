import 'package:flutter/material.dart';
import 'Sorts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('예매율순'),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.sort),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Sorts.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Text('내용'),
    );
  }

  void choiceAction(String choice) {
    print(choice);
  }
}
