import 'package:mvvm/data/network/BaseApiservices.dart';
import 'package:mvvm/model/movies_list_model.dart';
import '../data/network/NetworkApiServiecs.dart';
import '../res/app_url.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<MoviesListModel> fetchMoviesList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MoviesListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
