import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/search_response.dart';

import 'package:peliculas/helpers/debouncer.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey    = 'f5e78471df34c59a1eb7c39edf01a036';
  String _baseUrl   = 'api.themoviedb.org';
  String _language  = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies   = [];

  int _popularPage = 0;

  // Almacenar casts
  Map<int, List<Cast>> _moviesCast = {};

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  // Stream busqueda
  final StreamController<List<Movie>>
    _suggestionStreamController = new StreamController.broadcast();
  // El warning es por que falta cerrarlo con
  // _suggestionStreamController.close();, pero no en este caso no es necesario
  
  Stream<List<Movie>>
    get suggestionStream => this._suggestionStreamController.stream;

  // Almacenar ultima busqueda
  String _lastQuery = '';
  List<Movie> _lastQueryResult = [];

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  _getJsonData(String endPoint, [int page = 1]) async {
    final url = Uri.https(
      _baseUrl,
      endPoint,
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page',
      }
    );

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData            = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse  = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    
    // Redibujar widgets
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData        = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [ ...popularMovies, ...popularResponse.results ];
    
    // Redibujar widgets
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if(_moviesCast.containsKey(movieId)) {
      return _moviesCast[movieId]!;
    }

    final jsonData        = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    _moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    if(query == _lastQuery) {
      return _lastQueryResult;
    }

    _lastQuery = query;
    
    final url = Uri.https(
      _baseUrl,
      '3/search/movie',
      {
        'api_key': _apiKey,
        'language': _language,
        'query': query,
      }
    );

    final response        = await http.get(url);
    final searchResponse  = SearchResponse.fromJson(response.body);
    _lastQueryResult      = searchResponse.results;

    return searchResponse.results;
  }

  void searchMovieBySuggestions( String searchTerm ) async {
    final results = await this.searchMovie(searchTerm);
    this._suggestionStreamController.add(results);
  }

  void getSuggestionsByQuery( String searchTerm ) async {
    // Si la busqueda anterior es igual a la actual, buscamos sin Timer
    if(searchTerm == _lastQuery) {
      searchMovieBySuggestions(searchTerm);
      return;
    }
    
    debouncer.value = searchTerm;
    debouncer.onValue = ( value ) async {
      searchMovieBySuggestions(value);
    };
  }
}