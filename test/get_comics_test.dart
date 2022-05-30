import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:xkcd_comics_app/data/app_exception.dart';
import 'package:xkcd_comics_app/models/comics_model.dart';
import 'package:xkcd_comics_app/repository/comics_repo.dart';

final comicsRepo = ComicsRepo();
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
  group('get comics', () {
    test(
        'returns current comic object if not passing an id and the http call completes successfully',
        () async {
      MockClient((request) async {
        return Response(json.encode(comicObj), 200);
      });

      final result = await comicsRepo.getComics();
      expect(result, isA<Comics>());
    });

    test(
        'returns comic object if the id is exist and the http call completes successfully',
        () async {
      MockClient((request) async {
        return Response(json.encode(comicObj), 200);
      });

      final result = await comicsRepo.getComics(comicId: 2);
      expect(result, isA<Comics>());
    });

    test('returns a Not Found if the comic id not exist', () async {
      MockClient((request) async {
        return Response('Not Found', 404);
      });

      expect(() => comicsRepo.getComics(comicId: 800000),
          throwsA(const TypeMatcher<NotFoundException>()));
    });
  });
}
