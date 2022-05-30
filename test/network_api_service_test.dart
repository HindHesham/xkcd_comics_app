import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:xkcd_comics_app/data/app_exception.dart';
import 'package:xkcd_comics_app/data/network/base_api_service.dart';
import 'package:xkcd_comics_app/data/network/network_api_service.dart';

final BaseApiService _apiService = NetworkApiService();
void main() {
  final comicObj = {
    "month": "5",
    "num": 2625,
    "link": "",
    "year": "2022",
    "news": "",
    "safe_title": "Field Topology",
    "transcript": "",
    "alt":
        "The combination croquet set/10-lane pool can also be used for some varieties of foosball and Skee-Ball.",
    "img": "https://imgs.xkcd.com/comics/field_topology.png",
    "title": "Field Topology",
    "day": "27"
  };

  group('http get request', () {
    test('returns a dynamic object if the http call completes successfully',
        () async {
      MockClient((request) async {
        return Response(json.encode(comicObj), 200);
      });

      final result = await _apiService.getResponse('info.0.json');
      expect(result, isA<dynamic>());
    });

    test(
        'returns a NotFoundException if the http call completes with not found response',
        () async {
      MockClient((request) async {
        return Response('Not Found', 404);
      });

      expect(() => _apiService.getResponse('infoo.0.json'),
          throwsA(const TypeMatcher<NotFoundException>()));
    });
  });
}
