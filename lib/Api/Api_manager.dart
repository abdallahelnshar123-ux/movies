import 'package:dio/dio.dart';
import 'package:movies/Api/model/movie_model.dart';

/*

https://movies-api.accel.li/api/v2/list_movies.json

 */

class ApiManager {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://movies-api.accel.li/api/v2/",
    )
  );

  static Future<MovieModel> getMovies() async {
    try{
      var response = await dio.get("list_movies.json");
      var json = response.data;
      return MovieModel.fromJson(json);
    }
    catch(e){
      rethrow;
    }
  }
  static Future<MovieModel> getMoviesByCategory(String gatergory) async {
    try{
      var response = await dio.get("list_movies.json",queryParameters: {
        "genre":gatergory
      });
      var json = response.data;
      return MovieModel.fromJson(json);
    }catch(e){
      rethrow;
    }
  }
}