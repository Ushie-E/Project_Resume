import 'package:flutter/material.dart';

import '../const.dart';

class CardFile extends StatelessWidget {
  final String note;
  const CardFile({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: SizedBox(
        height: 50,
        width: 160,
        child: Center(
          child: Text(
            note,
            style: const TextStyle(
              fontSize: 18,
              color: kColor9,
            ),
          ),
        ),
      ),
    );
  }
}
