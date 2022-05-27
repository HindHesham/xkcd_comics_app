import 'package:flutter/cupertino.dart';
import 'package:xkcd_comics_app/data/response/api_response.dart';
import 'package:xkcd_comics_app/models/comics_model.dart';
import 'package:xkcd_comics_app/repository/comics_repo.dart';

class ComicsVM extends ChangeNotifier {
  final _comicsRepo = ComicsRepo();
  ApiResponse<Comics> comics = ApiResponse.loading();

  void _setComics(ApiResponse<Comics> response) {
    comics = response;
    notifyListeners();
  }

  Future<void> fetchComics({int? comicId}) async {
    _setComics(ApiResponse.loading());
    await _comicsRepo
        .getComics(comicId: comicId)
        .then((value) => _setComics(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setComics(ApiResponse.error(error.toString())));
  }
}
