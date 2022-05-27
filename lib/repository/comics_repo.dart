import 'package:xkcd_comics_app/data/network/api_end_points.dart';
import 'package:xkcd_comics_app/data/network/base_api_service.dart';
import 'package:xkcd_comics_app/data/network/network_api_service.dart';
import 'package:xkcd_comics_app/models/comics_model.dart';

class ComicsRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<Comics> getComics({int? comicId}) async {
    try {
      String url = ApiEndPoints().getComics;
      if (comicId != null) {
        url = '$comicId/${ApiEndPoints().getComics}';
      }
      dynamic response = await _apiService.getResponse(url);
      final res = Comics.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
