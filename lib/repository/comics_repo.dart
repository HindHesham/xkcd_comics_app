import 'package:xkcd_comics_app/data/network/base_api_service.dart';
import 'package:xkcd_comics_app/data/network/network_api_service.dart';
import 'package:xkcd_comics_app/models/comics_model.dart';

class ComicsRepo {
  final BaseApiService _apiService = NetworkApiService();

  Future<Comics> getComics() async {
    try {
      dynamic response = await _apiService.getResponse(_apiService.baseUrl);
      final res = Comics.fromJson(response);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
