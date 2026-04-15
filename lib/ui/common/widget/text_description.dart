import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/const.dart';

class TextDescription extends StatefulWidget {
  final String text;
  final String write;
  const TextDescription({Key? key, required this.text, required this.write})
      : super(key: key);

  @override
  State<TextDescription> createState() => _TextDescriptionState();
}

class _TextDescriptionState extends State<TextDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.text,
          style: const TextStyle(
            color: kColor,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
