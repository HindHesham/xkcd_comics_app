import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_comics_app/data/response/status.dart';
import 'package:xkcd_comics_app/models/comics_model.dart';
import 'package:xkcd_comics_app/shared/widgets/generic_error_widget.dart';
import 'package:xkcd_comics_app/shared/widgets/generic_loading_widget.dart';
import 'package:xkcd_comics_app/shared/widgets/icons_button_widget.dart';
import 'package:xkcd_comics_app/view_model/comics_vm.dart';

import '../main.dart';

class ComicsViewerPage extends StatefulWidget {
  const ComicsViewerPage({Key? key}) : super(key: key);

  @override
  _ComicsViewerPageState createState() => _ComicsViewerPageState();
}

class _ComicsViewerPageState extends State<ComicsViewerPage> {
  final ComicsVM comicsModel = ComicsVM();
  var nowDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    comicsModel.fetchComics();
  }

  //calling prev and next Comic
  _getPrevOrNextComic(int comicId) async {
    await comicsModel.fetchComics(comicId: comicId);
  }

  //get comic date and and compare current date and comic date for shown or hidden next button
  bool _compareCurrentDateAndComicDate(
      String? year, String? month, String? day) {
    if (month?.length == 1) {
      month = "0$month";
    }
    String comicDate = year! + '-' + month! + '-' + day!;
    return _getDifferenceBetweenDates(comicDate);
  }

  bool _getDifferenceBetweenDates(String comicDate) {
    final difference = (DateTime.parse(comicDate)).difference(nowDate).inDays;

    if (difference != -1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(MyApp.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ChangeNotifierProvider<ComicsVM>(
        create: (BuildContext context) => comicsModel,
        child: Consumer<ComicsVM>(builder: (context, comicsModel, _) {
          switch (comicsModel.comics.status) {
            case Status.LOADING:
              return const GenericLoadingWidget();
            case Status.ERROR:
              return GenericErrorWidget(comicsModel.comics.message ?? "NA");
            case Status.COMPLETED:
              return _comicsWidget(comicsModel.comics.data!);

            default:
          }
          return Container();
        }),
      ),
    );
  }

  //comics viewer widget
  Widget _comicsWidget(Comics comicObj) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //buttons and title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //prev
                iconsButton(
                  onPressed: () {
                    _getPrevOrNextComic(comicObj.number! - 1);
                  },
                  buttonIcon: Icons.navigate_before,
                ),

                SizedBox(width: MediaQuery.of(context).size.width * 0.03),

                //title
                Text(comicObj.title!),

                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                //next

                _compareCurrentDateAndComicDate(
                        comicsModel.comics.data!.year,
                        comicsModel.comics.data!.month,
                        comicsModel.comics.data!.day)
                    ? iconsButton(
                        onPressed: () {
                          _getPrevOrNextComic(comicObj.number! + 1);
                        },
                        buttonIcon: Icons.navigate_next,
                      )
                    : Container()
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            //image
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.network("${comicObj.img}", fit: BoxFit.contain,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            //date
            Text('${comicObj.month} / ${comicObj.day} / ${comicObj.year}'),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            //transcript
            Container(
              child: comicObj.transcript!.isNotEmpty
                  ? Text(comicObj.transcript!)
                  : Text(comicObj.alt!),
            )
          ],
        ),
      ],
    );
  }
}
