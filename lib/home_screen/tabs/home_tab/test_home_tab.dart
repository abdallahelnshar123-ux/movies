import 'package:flutter/material.dart';
import 'package:movies/Api/Api_manager.dart';
import 'package:movies/Api/model/movie_model.dart';
import 'package:movies/utils/app_styles.dart';

class HomeTab extends StatelessWidget {
  final MovieModel movie = MovieModel();
  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieModel>(future: ApiManager.getMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error snapshot");
        }
        if (snapshot.data?.status == "error") {
          print("error status ");
          return Text("Error status");
        }
        var moviesList = snapshot.data?.data?.movies ?? [];
        if (moviesList.isEmpty) {
          return Center(
            child: Text(
              "No Sources Found",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          );
        }
        return Scaffold(
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Text(moviesList[index].title??"");
            },
            itemCount: moviesList.length,
          ),
        );
      },
    );
  }
}
