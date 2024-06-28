import 'package:flutter/material.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/movies_list_model.dart';
import 'package:mvvm/repository/home_repo.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  ApiResponse<MoviesListModel> moviesList = ApiResponse.loading();
  setMoviesList(ApiResponse<MoviesListModel> response) {
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());
    _myRepo.fetchMoviesList().then((value) {
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
