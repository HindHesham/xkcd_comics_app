import 'package:flutter/material.dart';

class GenericErrorWidget extends StatelessWidget {
  final String msg;

  const GenericErrorWidget(this.msg, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      msg,
    ));
  }
}
