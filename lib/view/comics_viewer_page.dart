import 'package:flutter/material.dart';
import 'package:xkcd_comics_app/shared/widgets/icons_button_widget.dart';

import '../main.dart';

class ComicsViewerPage extends StatefulWidget {
  const ComicsViewerPage({Key? key}) : super(key: key);

  @override
  _ComicsViewerPageState createState() => _ComicsViewerPageState();
}

class _ComicsViewerPageState extends State<ComicsViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(MyApp.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
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
                      print('prev');
                    },
                    buttonIcon: Icons.navigate_before,
                  ),

                  const SizedBox(
                    width: 15,
                  ),
                  //title
                  const Text('comic name'),

                  const SizedBox(
                    width: 15,
                  ),

                  //next
                  iconsButton(
                    onPressed: () {
                      print('next');
                    },
                    buttonIcon: Icons.navigate_next,
                  ),
                ],
              ),

              //image
              Container(
                width: double.infinity,
                height: 400.0,
                child: Image.network(
                  "https://imgs.xkcd.com/comics/goofs.png",
                  fit: BoxFit.contain,
                ),
              ),

              //date
              Container(
                child: Text('Month day, year'),
              ),

              const SizedBox(
                height: 15,
              ),

              //transcript
              Container(
                child: Text(
                    "The film is set in 2018, but when Commander Bremberly chases the hologram through Times Square, there's a billboard for Avengers: Age of Ultron. Depending on the date, that billboard would have been advertising either Infinity War or this movie."),
              )
            ],
          ),
        ],
      ),
    );
  }
}
