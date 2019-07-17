import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/blocs/movie_detail_bloc_provider.dart';
import 'package:flutter_bloc_pattern/src/blocs/movies_bloc.dart';
import 'package:flutter_bloc_pattern/src/models/now_playing_movies_model.dart';
import 'package:flutter_bloc_pattern/src/ui/drawerUI.dart';
import 'package:flutter_bloc_pattern/src/ui/movie_detail.dart';

class NowPlayingMoviesList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NowPlayingMoviesListState();
  }

}
class NowPlayingMoviesListState extends State<NowPlayingMoviesList> {
  @override
  void initState(){
    super.initState();
    bloc.fetchAllNowPlayingMovies();
  }

  @override
  void dispose(){
//    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.allNowPlayingMovies,
        builder: (context, AsyncSnapshot<NowPlayingMoviesModel> snapshot) {
          print(snapshot.hasData);
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      );
  }

  Widget buildList(AsyncSnapshot<NowPlayingMoviesModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data
                    .results[index].posterPath}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailpage(snapshot.data, index),
            ),
          );
        });
  }

  openDetailpage(NowPlayingMoviesModel data, int index){
    final movie = data.results[index];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MovieDetailBlocProvider(
          child: MovieDetail(
            title: movie.title,
            posterUrl: movie.backdropPath,
            description: movie.overview,
            releaseDate: movie.releasDate,
            voteAverage: movie.voteAverage.toString(),
            movieId: movie.id,
          ),
        );
      }),
    );
  }
}