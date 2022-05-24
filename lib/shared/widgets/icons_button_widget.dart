import 'package:flutter/material.dart';

Widget iconsButton({
  required void Function()? onPressed,
  required IconData buttonIcon,
}) =>
    ElevatedButton(
      onPressed: onPressed,
      child: Icon(buttonIcon),
    );
