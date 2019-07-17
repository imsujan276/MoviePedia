import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/ui/drawerUI.dart';
import 'package:flutter_bloc_pattern/src/ui/movie_list.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:flutter_bloc_pattern/src/ui/now_playing_movies_list.dart';
import 'package:flutter_bloc_pattern/src/ui/upcoming_movies_list.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'MoviePedia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
//      home: Scaffold(
//        body: MovieList(),
//      ),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
//            appBar: AppBar(
//              title: Text('MoviePedia'),
//              centerTitle: true,
//              bottom: TabBar(
//                  tabs: <Widget>[
//                    Tab(
//                      icon: Icon(Icons.movie),
//                    ),
//                    Tab(
//                      icon: Icon(Icons.movie),
//                    )
//                  ]
//              ),
//            ),
            appBar: ShiftingTabBar(
              color: Colors.white,
              tabs: [
                ShiftingTab(
                  icon: Icon(Icons.home),
                  text: "Now Playing",
                ),
                ShiftingTab(
                    icon: Icon(Icons.directions_bike),
                    text: "Up-Coming"
                ),
                ShiftingTab(
                    icon: Icon(Icons.directions_bike),
                    text: "Popular"
                ),
              ],
            ),
            body: TabBarView(
                children: <Widget>[
                  NowPlayingMoviesList(),
                  UpcomingMoviesList(),
                  MovieList()
                ],
            ),

            drawer: Drawer(
              child: DrawerUI(),
            ),
          )
      ),

    );
  }

}