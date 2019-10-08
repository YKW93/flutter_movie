import 'package:flutter/material.dart';
import 'package:flutter_movie/model/response/movie_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_movie/page/movie_grid_page.dart';
import 'package:flutter_movie/page/movie_list_page.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  MovieResponse _movieResponse;
  int _selectedTabIndex = 0;
  int _selectedSortIndex = 0;

  @override
  void initState() {
    super.initState();
    _requestMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(_getAppBarTitleBySortIndex(_selectedSortIndex)),
        actions: <Widget>[
          _buildPopupMenuButton(),
        ],
      ),
      body: _buildContents(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPopupMenuButton() {
    return PopupMenuButton<int>(
      icon: Icon(Icons.sort),
      onSelected: _onSortMethodTap,
      itemBuilder: (context) {
        return [
          PopupMenuItem(value: 0, child: Text(_getMenuTitleBySortIndex(0))),
          PopupMenuItem(value: 1, child: Text(_getMenuTitleBySortIndex(1))),
          PopupMenuItem(value: 2, child: Text(_getMenuTitleBySortIndex(2)))
        ];
      },
    );
  }

  Widget _buildContents() {
    Widget contentsWidget;
    if (_movieResponse == null) {
      contentsWidget = Center(child: CircularProgressIndicator());
    } else {
      if (_selectedTabIndex == 0) {
        contentsWidget = MovieListPage(_movieResponse.movies);
      } else if (_selectedTabIndex == 1) {
        contentsWidget = MovieGridPage(_movieResponse.movies);
      } else {
        contentsWidget = Container();
      }
    }
    return contentsWidget;
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          title: Text('List'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_on),
          title: Text('Grid'),
        ),
      ],
      currentIndex: _selectedTabIndex,
      onTap: _onTabBarTap,
    );
  }

  void _onSortMethodTap(int index) {
    setState(() {
      _selectedSortIndex = index;
    });
    _requestMovies();
  }

  void _onTabBarTap(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  String _getAppBarTitleBySortIndex(int index) {
    switch (index) {
      case 0:
        return '예매율순';
      case 1:
        return '큐레이션';
      case 2:
        return "개봉일순";
      default:
        return '';
    }
  }

  String _getMenuTitleBySortIndex(int index) {
    switch (index) {
      case 0:
        return '예매율';
      case 1:
        return '큐레이션';
      case 2:
        return "개봉일";
      default:
        return '';
    }
  }

  void _requestMovies() async {
    setState(() {
      _movieResponse = null;
    });
    final response = await http.get(
        'http://connect-boxoffice.run.goorm.io/movies?order_type=$_selectedSortIndex');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final movieResponse = MovieResponse.fromJson(jsonData);
      setState(() {
        _movieResponse = movieResponse;
      });
    }
  }
}
