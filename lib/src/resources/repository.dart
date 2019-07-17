import 'dart:async';

import 'package:flutter_bloc_pattern/src/models/item_model.dart';
import 'package:flutter_bloc_pattern/src/models/now_playing_movies_model.dart';
import 'package:flutter_bloc_pattern/src/models/trailer_model.dart';
import 'package:flutter_bloc_pattern/src/models/upcoming_movies_model.dart';
import 'package:flutter_bloc_pattern/src/resources/movie_api_provider.dart';

class Repository{
  final movieApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies () => movieApiProvider.fetchMovieList();

  Future<UpcomingMoviesModel> fetchAllUpcomingMovies () => movieApiProvider.fetchUpcomingMovieList();

  Future<NowPlayingMoviesModel> fetchAllNowPlayingMovies () => movieApiProvider.fetchNowPlayingMovieList();

  Future<TrailerModel> fetchTrailers(int movieId) => movieApiProvider.fetchTrailer(movieId);
}