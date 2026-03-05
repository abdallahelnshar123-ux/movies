/// status : "ok"
/// status_message : "Query was successful"
/// data : {"movie":{"id":15,"url":"https://yts.bz/movies/16-blocks-2006","imdb_code":"tt0450232","title":"16 Blocks","title_english":"16 Blocks","title_long":"16 Blocks (2006)","slug":"16-blocks-2006","year":2006,"rating":6.6,"runtime":102,"genres":["Action","Crime","Drama","Thriller"],"like_count":55,"description_intro":"An aging alcoholic cop is assigned the task of escorting a witness from police custody to a courthouse 16 blocks away. There are, however, chaotic forces at work that prevent them from making it in one piece.","description_full":"An aging alcoholic cop is assigned the task of escorting a witness from police custody to a courthouse 16 blocks away. There are, however, chaotic forces at work that prevent them from making it in one piece.","yt_trailer_code":"55nKvGV0APA","language":"en","mpa_rating":"PG-13","background_image":"https://yts.bz/assets/images/movies/16_Blocks_2006/background.jpg","background_image_original":"https://yts.bz/assets/images/movies/16_Blocks_2006/background.jpg","small_cover_image":"https://yts.bz/assets/images/movies/16_Blocks_2006/small-cover.jpg","medium_cover_image":"https://yts.bz/assets/images/movies/16_Blocks_2006/medium-cover.jpg","large_cover_image":"https://yts.bz/assets/images/movies/16_Blocks_2006/large-cover.jpg","medium_screenshot_image1":"https://yts.bz/assets/images/movies/16_Blocks_2006/medium-screenshot1.jpg","medium_screenshot_image2":"https://yts.bz/assets/images/movies/16_Blocks_2006/medium-screenshot2.jpg","medium_screenshot_image3":"https://yts.bz/assets/images/movies/16_Blocks_2006/medium-screenshot3.jpg","large_screenshot_image1":"https://yts.bz/assets/images/movies/16_Blocks_2006/large-screenshot1.jpg","large_screenshot_image2":"https://yts.bz/assets/images/movies/16_Blocks_2006/large-screenshot2.jpg","large_screenshot_image3":"https://yts.bz/assets/images/movies/16_Blocks_2006/large-screenshot3.jpg","cast":[{"name":"Bruce Willis","character_name":"Det. Jack Mosley","url_small_image":"https://yts.bz/assets/images/actors/thumb/nm0000246.jpg","imdb_code":"0000246"},{"name":"Spencer Kayden","character_name":"Juror","url_small_image":"https://yts.bz/assets/images/actors/thumb/nm0443248.jpg","imdb_code":"0443248"},{"name":"Tig Fong","character_name":"Briggs","url_small_image":"https://yts.bz/assets/images/actors/thumb/nm0284609.jpg","imdb_code":"0284609"},{"name":"Tom Wlaschiha","character_name":"Bus Passenger","url_small_image":"https://yts.bz/assets/images/actors/thumb/nm0937239.jpg","imdb_code":"0937239"}],"torrents":[{"url":"https://yts.bz/torrent/download/8619B57A3F39F1B49A1A698EA5400A883928C0A2","hash":"8619B57A3F39F1B49A1A698EA5400A883928C0A2","quality":"720p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":3,"peers":0,"size":"702.04 MB","size_bytes":736142295,"date_uploaded":"2015-10-31 20:47:35","date_uploaded_unix":1446320855},{"url":"https://yts.bz/torrent/download/2A4B9A41C92A20A06C8846E66AD9B5BC4B669BC6","hash":"2A4B9A41C92A20A06C8846E66AD9B5BC4B669BC6","quality":"1080p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":24,"peers":0,"size":"1.40 GB","size_bytes":1503238554,"date_uploaded":"2015-10-31 20:47:38","date_uploaded_unix":1446320858}],"date_uploaded":"2015-10-31 20:47:35","date_uploaded_unix":1446320855}}
/// meta : {"api_version":2,"execution_time":"0 ms"}
library;

import 'inner_classes/meta.dart';
import 'inner_classes/movie.dart';

class MovieDetailsResponse {
  MovieDetailsResponse({
      this.status, 
      this.statusMessage, 
      this.data, 
      this.meta,});

  MovieDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? Meta.fromJson(json['@meta']) : null;
  }
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (meta != null) {
      map['@meta'] = meta?.toJson();
    }
    return map;
  }

}

/// api_version : 2
/// execution_time : "0 ms"



/// movie : {"id":15,"url":"https://yts.bz/movies/16-blocks-2006","imdb_code":"tt0450232","title":"16 Blocks","title_english":"16 Blocks","title_long":"16 Blocks (2006)","slug":"16-blocks-2006","year":2006,"rating":6.6,"runtime":102,"genres":["Action","Crime","Drama","Thriller"],"like_count":55,"description_intro":"An aging alcoholic cop is assigned the task of escorting a witness from police custody to a courthouse 16 blocks away. There are, however, chaotic forces at work that prevent them from making it in one piece.","description_full":"An aging alcoholic cop is assigned the task of escorting a witness from police custody to a courthouse 16 blocks away. There are, however, chaotic forces at work that prevent them from making it in one piece.","yt_trailer_code":"55nKvGV0APA","language":"en","mpa_rating":"PG-13","background_image":"https://yts.bz/assets/images/movies/16_Blocks_2006/background.jpg","background_image_original":"https://yts.bz/assets/images/movies/16_Blocks_2006/background.jpg","small_cover_image":"https://yts.bz/assets/images/movies/16_Blocks_2006/small-cover.jpg","medium_cover_image":"https://yts.bz/assets/images/movies/16_Blocks_2006/medium-cover.jpg","large_cover_image":"https://yts.bz/assets/images/movies/16_Blocks_2006/large-cover.jpg","medium_screenshot_image1":"https://yts.bz/assets/images/movies/16_Blocks_2006/medium-screenshot1.jpg","medium_screenshot_image2":"https://yts.bz/assets/images/movies/16_Blocks_2006/medium-screenshot2.jpg","medium_screenshot_image3":"https://yts.bz/assets/images/movies/16_Blocks_2006/medium-screenshot3.jpg","large_screenshot_image1":"https://yts.bz/assets/images/movies/16_Blocks_2006/large-screenshot1.jpg","large_screenshot_image2":"https://yts.bz/assets/images/movies/16_Blocks_2006/large-screenshot2.jpg","large_screenshot_image3":"https://yts.bz/assets/images/movies/16_Blocks_2006/large-screenshot3.jpg","cast":[{"name":"Bruce Willis","character_name":"Det. Jack Mosley","url_small_image":"https://yts.bz/assets/images/actors/thumb/nm0000246.jpg","imdb_code":"0000246"},{"name":"Spencer Kayden","character_name":"Juror","url_small_image":"https://yts.bz/assets/images/actors/thumb/nm0443248.jpg","imdb_code":"0443248"},{"name":"Tig Fong","character_name":"Briggs","url_small_image":"https://yts.bz/assets/images/actors/thumb/nm0284609.jpg","imdb_code":"0284609"},{"name":"Tom Wlaschiha","character_name":"Bus Passenger","url_small_image":"https://yts.bz/assets/images/actors/thumb/nm0937239.jpg","imdb_code":"0937239"}],"torrents":[{"url":"https://yts.bz/torrent/download/8619B57A3F39F1B49A1A698EA5400A883928C0A2","hash":"8619B57A3F39F1B49A1A698EA5400A883928C0A2","quality":"720p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":3,"peers":0,"size":"702.04 MB","size_bytes":736142295,"date_uploaded":"2015-10-31 20:47:35","date_uploaded_unix":1446320855},{"url":"https://yts.bz/torrent/download/2A4B9A41C92A20A06C8846E66AD9B5BC4B669BC6","hash":"2A4B9A41C92A20A06C8846E66AD9B5BC4B669BC6","quality":"1080p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":24,"peers":0,"size":"1.40 GB","size_bytes":1503238554,"date_uploaded":"2015-10-31 20:47:38","date_uploaded_unix":1446320858}],"date_uploaded":"2015-10-31 20:47:35","date_uploaded_unix":1446320855}

class Data {
  Data({
      this.movie,});

  Data.fromJson(dynamic json) {
    movie = json['movie'] != null ? Movie.fromJson(json['movie']) : null;
  }
  Movie? movie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (movie != null) {
      map['movie'] = movie?.toJson();
    }
    return map;
  }

}




/// name : "Bruce Willis"
/// character_name : "Det. Jack Mosley"
/// url_small_image : "https://yts.bz/assets/images/actors/thumb/nm0000246.jpg"
/// imdb_code : "0000246"

class Cast {
  Cast({
      this.name, 
      this.characterName, 
      this.urlSmallImage, 
      this.imdbCode,});

  Cast.fromJson(dynamic json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }
  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['character_name'] = characterName;
    map['url_small_image'] = urlSmallImage;
    map['imdb_code'] = imdbCode;
    return map;
  }

}