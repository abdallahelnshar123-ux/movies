import 'package:dio/dio.dart';
import 'package:movies/Api/model/Movie_suggestion_response.dart';
import 'package:movies/Api/model/movie_details_response.dart';
import 'package:movies/Api/model/movie_model.dart';

/*

https://movies-api.accel.li/api/v2/list_movies.json

 */

class ApiManager {
  static final Dio dio = Dio();

  static Future<MovieModel> getMovies() async {
    try{
      var response = await dio.get("https://movies-api.accel.li/api/v2/list_movies.json",);
      var json = response.data;
      return MovieModel.fromJson(json);
    }
    catch(e){
      rethrow;
    }
  }
//https://movies-api.accel.li/api/v2/movie_details.json?movie_id=15&with_images=true&with_cast=true

  static Future<MovieDetailsResponse> getMoviesDetails( int movieId) async {
    try{
      var response = await dio.get("https://movies-api.accel.li/api/v2/movie_details.json",
          queryParameters: {
            'movie_id' : movieId ,
            'with_images' : true,
            'with_cast' : true,
          });
      var json = response.data;
      return MovieDetailsResponse.fromJson(json);
    }
    catch(e){
      rethrow;
    }
  }

//https://movies-api.accel.li/api/v2/movie_suggestions.json?movie_id=10


  static Future<MovieSuggestionResponse> getSuggestionDetails( int movieId) async {
    try{
      var response = await dio.get("https://movies-api.accel.li/api/v2/movie_suggestions.json",
          queryParameters: {
            'movie_id' : movieId ,
          });
      var json = response.data;
      return MovieSuggestionResponse.fromJson(json);
    }
    catch(e){
      rethrow;
    }
  }
}
