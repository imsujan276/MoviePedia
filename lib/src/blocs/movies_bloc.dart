import 'package:flutter_bloc_pattern/src/models/item_model.dart';
import 'package:flutter_bloc_pattern/src/models/now_playing_movies_model.dart';
import 'package:flutter_bloc_pattern/src/models/upcoming_movies_model.dart';
import 'package:flutter_bloc_pattern/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();
  final _upcomingMoviesFetcher = PublishSubject<UpcomingMoviesModel>();
  final _nowPlayingMoviesFetcher = PublishSubject<NowPlayingMoviesModel>();

  Observable<ItemModel> get allMovies => _moviesFetcher.stream;
  Observable<UpcomingMoviesModel> get allUpcomingMovies => _upcomingMoviesFetcher.stream;
  Observable<NowPlayingMoviesModel> get allNowPlayingMovies => _nowPlayingMoviesFetcher.stream;

  fetchAllMovies() async{
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  fetchAllUpcomingMovies() async{
    UpcomingMoviesModel upcomingMoviesModel = await _repository.fetchAllUpcomingMovies();
    _upcomingMoviesFetcher.sink.add(upcomingMoviesModel);
  }

  fetchAllNowPlayingMovies() async{
    NowPlayingMoviesModel nowPlayingMoviesModel = await _repository.fetchAllNowPlayingMovies();
    _nowPlayingMoviesFetcher.sink.add(nowPlayingMoviesModel);
  }

  dispose() {
    _moviesFetcher?.close();
    _upcomingMoviesFetcher?.close();
    _nowPlayingMoviesFetcher?.close();
  }
}

final bloc = MoviesBloc();