import 'package:flutter/material.dart';
import 'package:flutter_movie/model/Sorts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'list_page.dart';
import 'grid_page.dart';
import 'package:flutter_movie/model/remote/Movie.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();

  static Widget showLoading() {
    return Container(
      alignment: Alignment.center,
      child: new CircularProgressIndicator(),
    );
  }
}

class _TabPageState extends State<TabPage> {

  int _selectedIndex = 0;

  Future<Movie> _getMovieList() async {
    http.Response response =
    await http.get('http://connect-boxoffice.run.goorm.io/movies');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('예매율순'),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.sort),
            onSelected: clickFilter,
            itemBuilder: (BuildContext context) {
              return Sorts.filters.map((String sort) {
                return PopupMenuItem<String>(
                  value: sort,
                  child: Text(sort),
                );
              }).toList();
            },
          )
        ],
      ),
      body: changePage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list), title: Text('List')),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_on), title: Text('Grid')),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void clickFilter(String sort) {
    print(sort);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget changePage(int index) {
    return FutureBuilder<Movie>(
      future: _getMovieList(),
      builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return TabPage.showLoading();
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              if (index == 0) {
                return ListPage(snapshot.data.movies);
              }
              else {
                return GridPage(snapshot.data.movies);
              }
        }
      },
    );
  }
}
