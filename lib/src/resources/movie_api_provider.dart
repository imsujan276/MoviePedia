import 'dart:async';
import 'package:flutter_bloc_pattern/src/models/item_model.dart';
import 'package:flutter_bloc_pattern/src/models/now_playing_movies_model.dart';
import 'package:flutter_bloc_pattern/src/models/trailer_model.dart';
import 'package:flutter_bloc_pattern/src/models/upcoming_movies_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class MovieApiProvider{
  Client client = Client();
  final _apiKey = "f55fbda0cb73b855629e676e54ab6d8e";
  final _baseURL = "http://api.themoviedb.org/3/movie";

  Future<ItemModel> fetchMovieList() async{
    final response = await client
        .get("$_baseURL/popular?api_key=$_apiKey");

    if(response.statusCode == 200){
      return ItemModel.fromJSON(json.decode(response.body));
    }
    else{
      throw Exception('failed to laod data');
    }
  }

  Future<UpcomingMoviesModel> fetchUpcomingMovieList() async{
    final response = await client
        .get("$_baseURL/upcoming?api_key=$_apiKey");

    if(response.statusCode == 200){
      return UpcomingMoviesModel.fromJSON(json.decode(response.body));
    }
    else{
      throw Exception('failed to laod data');
    }
  }

  Future<NowPlayingMoviesModel> fetchNowPlayingMovieList() async{
    final response = await client
        .get("$_baseURL/now_playing?api_key=$_apiKey");

    if(response.statusCode == 200){
      return NowPlayingMoviesModel.fromJSON(json.decode(response.body));
    }
    else{
      throw Exception('failed to laod data');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response = await client
        .get("$_baseURL/$movieId/videos?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}