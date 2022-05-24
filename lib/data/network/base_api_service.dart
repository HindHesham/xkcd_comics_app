abstract class BaseApiService {
  final String baseUrl = "https://xkcd.com/info.0.json";

  Future<dynamic> getResponse(String url);
}
