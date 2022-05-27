abstract class BaseApiService {
  final String baseUrl = "https://xkcd.com/";

  Future<dynamic> getResponse(String url);
}
