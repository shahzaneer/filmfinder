import 'dart:convert';
import "package:hive/hive.dart";
part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String originalTitle;
  @HiveField(2)
  final String? backdropPath;
  @HiveField(3)
  final String? releaseDate;
  @HiveField(4)
  final String? overview;
  @HiveField(5)
  final String? posterPath;
  @HiveField(6)
  final List<dynamic> genreIds;

  MovieModel({
    required this.originalTitle,
    required this.id,
    this.backdropPath,
    this.releaseDate,
    this.overview,
    required this.genreIds,
    this.posterPath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'original_title': originalTitle,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'overview': overview,
      'genre_ids': genreIds,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'].toString(),
      originalTitle: map['original_title'] as String,
      backdropPath: map['backdrop_path'] ?? "",
      releaseDate: map['release_date'] as String,
      overview: map['overview'] as String,
      posterPath: map['poster_path'] ?? "",
      genreIds: List<dynamic>.from(
        (map['genre_ids'] as List<dynamic>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<MovieModel> toList(dynamic map) {
    List<MovieModel> list = [];
    for (var i = 0; i < map.length; i++) {
      list.add(MovieModel.fromMap(map[i]));
    }
    return list;
  }
}
