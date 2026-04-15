import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/common/widget/card_file.dart';

import '../ui/common/const.dart';

class MaterialView extends StatelessWidget {
  const MaterialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text(
                'Skill',
                style: TextStyle(
                    fontSize: 20, color: kColor7, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardFile(
                  note: 'Interface Design',
                ),
                CardFile(note: 'Mobile Interface')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardFile(note: 'Mobile Creator'),
                CardFile(note: 'Visual testing '),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardFile(note: 'Mobile Texting'),
                CardFile(note: 'Usability Testing'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardFile(note: 'Mobile frame'),
                CardFile(note: 'Note Taking'),
              ],
            )
          ],
        )
      ],
    );
  }
}
