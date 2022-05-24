import 'package:flutter/material.dart';

class GenericErrorWidget extends StatelessWidget {
  final String msg;

  GenericErrorWidget(this.msg);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: Text(
      '$msg',
    )));
  }
}
