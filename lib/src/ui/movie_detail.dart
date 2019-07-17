import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/src/blocs/movie_detail_bloc.dart';
import 'package:flutter_bloc_pattern/src/blocs/movie_detail_bloc_provider.dart';
import 'package:flutter_bloc_pattern/src/models/trailer_model.dart';

import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class MovieDetail extends StatefulWidget {
  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  MovieDetail({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  State<StatefulWidget> createState() {
    return MovieDetailState(
      title: title,
      posterUrl: posterUrl,
      description: description,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      movieId: movieId,
    );
  }
}

class MovieDetailState extends State<MovieDetail> {
  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  MovieDetailBloc bloc;

  MovieDetailState({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  void didChangeDependencies() {
    bloc = MovieDetailBlocProvider.of(context);
    bloc.fetchTrailersById(movieId);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        //opacity: top == 80.0 ? 1.0 : 0.0,
                        opacity: 1.0,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(fontSize: 16.0),
                        )),
                    background: Image.network(
                      "https://image.tmdb.org/t/p/w500$posterUrl",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//                Container(margin: EdgeInsets.only(top: 5.0)),
//                Text(
//                  title,
//                  style: TextStyle(
//                    fontSize: 25.0,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                    Text(
                      voteAverage,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    Text(
                      releaseDate,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(
                  "Trailer",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                StreamBuilder(
                  stream: bloc.movieTrailers,
                  builder:
                      (context, AsyncSnapshot<Future<TrailerModel>> snapshot) {
                    if (snapshot.hasData) {
                      return FutureBuilder(
                        future: snapshot.data,
                        builder: (context,
                            AsyncSnapshot<TrailerModel> itemSnapShot) {
                          if (itemSnapShot.hasData) {
                            if (itemSnapShot.data.results.length > 0)
                              return trailerLayout(itemSnapShot.data);
                            else
                              return noTrailer(itemSnapShot.data);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noTrailer(TrailerModel data) {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  Widget trailerLayout(TrailerModel data) {
    if (data.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
//          trailerItem(data, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerModel data, int index) {
    return Expanded(
      child: InkResponse(
        enableFeedback: true,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.play_circle_filled),
              title: Text(
                data.results[index].name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
//            Container(
//              margin: EdgeInsets.all(5.0),
//              height: 100.0,
//              color: Colors.grey,
//              child: Center(child: Icon(Icons.play_circle_filled)),
//            ),
//            Text(
//              data.results[index].name,
//              maxLines: 1,
//              overflow: TextOverflow.ellipsis,
//            ),
          ],
        ),
        onTap: () => _openYoutube(data.results[index].key),
      ),
    );
  }

  _openYoutube(String videoId) async {
    try {
      await launch(
        'https://www.youtube.com/watch?v=$videoId',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          // or user defined animation.
//          animation: new CustomTabsAnimation(
//          startEnter: 'slide_up',
//          startExit: 'android:anim/fade_out',
//          endEnter: 'android:anim/fade_in',
//          endExit: 'slide_down',
//        ),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
