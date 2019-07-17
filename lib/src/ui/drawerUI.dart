import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/screens/popular_movies_screen.dart';
import 'package:flutter_bloc_pattern/src/ui/movie_list.dart';
import 'package:flutter_bloc_pattern/src/ui/now_playing_movies_list.dart';
import 'package:flutter_bloc_pattern/src/ui/upcoming_movies_list.dart';

class DrawerUI extends StatefulWidget {
  @override
  _DrawerUIState createState() => new _DrawerUIState();
}

class _DrawerUIState extends State<DrawerUI>{

  List pages = [
    'Popular Movies',
//    'Upcoming Movies',
//    'Now Playing Movies'
  ];
//  List pages = [];

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.0,
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Image.asset(
                    'images/main_logo.jpg',
                    fit: BoxFit.cover,
                  ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Item(index: index, title:pages[index]);
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}

class Item extends StatefulWidget {

  final int index;
  final String title;

  Item({this.index, this.title});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {

  @override
  void initState() {
    super.initState();
  }

 reverse(int index) async {
    Navigator.of(context).pop();
    switch(index){
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PopularMoviesScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpcomingMoviesList()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NowPlayingMoviesList()),
        );
        break;
      default:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MovieList()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            height: 75.0,
            child: RaisedButton(
              color: Colors.blueGrey,
              child: ListTile(
                leading: Icon(
                  Icons.movie
                ),
                title: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                ),
                subtitle: Text(
                  'Visit for more information on '+widget.title
                ),
//                trailing: Icon(
//                  Icons.arrow_forward_ios
//                ),
              ),
              onPressed: (){
                reverse(widget.index);
              },
            ),
          );
  }
}