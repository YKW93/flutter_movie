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

  int _selectedTabIndex = 0;
  int _selectedSortIndex = 0;

  Future<Movie> _getMovieList(int type) async {
    http.Response response =
    await http.get('http://connect-boxoffice.run.goorm.io/movies?order_type=$type');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('${SortHelper.getTitle(_selectedSortIndex)}순'),
        actions: <Widget>[
          PopupMenuButton<Sorts>(
            icon: Icon(Icons.sort),
            onSelected: clickFilter,
            itemBuilder: (BuildContext context) {
              return Sorts.values.map((Sorts sort) {
                return PopupMenuItem<Sorts>(
                  value: sort,
                  child: Text(SortHelper.getValue(sort)),
                );
              }).toList();
            },
          )
        ],
      ),
      body: changePage(_selectedTabIndex, _selectedSortIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list), title: Text('List')),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_on), title: Text('Grid')),
        ],
        currentIndex: _selectedTabIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void clickFilter(Sorts sort) {
    setState(() {
      _selectedSortIndex = sort.index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  Widget changePage(int index, int type) {
    return FutureBuilder<Movie>(
      future: _getMovieList(type),
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
