import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/ui/movie_list.dart';

class PopularMoviesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
          ),
          title: Text('Popular Movies'),
        ),
        body: MovieList(),
      ),
    );
  }

}