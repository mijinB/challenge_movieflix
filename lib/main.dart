import 'dart:convert';

import 'package:challenge_movieflix/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MovieFlix());
}

class MovieFlix extends StatelessWidget {
  const MovieFlix({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE3E3E3),
        primaryColor: const Color(0xFF6570FF),
        canvasColor: const Color(0xFF3F3F3F),
      ),
      home: HomeScreen(),
    );
  }
}

//------------------------------------------------------------------------------

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";

  static Future<List<HomeModel>> getHomeMovies(String detailUrl) async {
    List<HomeModel> homeInstances = [];
    final url = Uri.parse("$baseUrl/$detailUrl");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final movies = jsonDecode(utf8.decode(response.body.codeUnits));
      for (var movie in movies['results']) {
        homeInstances.add(HomeModel.fromJson(movie));
      }
      return homeInstances;
    }
    throw Error();
  }

  static Future<DetailModel> getDetailMovies(String detailUrl) async {
    final url = Uri.parse("$baseUrl/$detailUrl");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final movie = jsonDecode(utf8.decode(response.body.codeUnits));
      return DetailModel.fromJson(movie);
    }
    throw Error();
  }
}

//------------------------------------------------------------------------------

class DetailModel {
  final int id, runtime;
  final double voteAverage;
  final String overview, genres, homepage;

  DetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        runtime = json['runtime'],
        voteAverage = json['vote_average'],
        overview = json['overview'],
        genres = json['genres'].map((item) => item['name']).join(', '),
        homepage = json['homepage'];
}

//------------------------------------------------------------------------------

class HomeModel {
  final String originalTitle;
  final String posterPath;
  final int id;

  HomeModel.fromJson(Map<String, dynamic> json)
      : originalTitle = json['original_title'],
        posterPath = json['poster_path'],
        id = json['id'];
}
