import 'package:flutter/material.dart';
import 'package:project/ui/common/widget/image_picture.dart';
import 'package:project/ui/common/widget/text_description.dart';

class HeaderView extends StatefulWidget {
  const HeaderView({Key? key}) : super(key: key);

  @override
  State<HeaderView> createState() => _HeaderViewState();
}

class _HeaderViewState extends State<HeaderView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ImagePicture(radius: 100),
        TextDescription(
          text: ' ADARIKU USHIE EMMANUEL',
          write: 'Mobile Developer',
        ),
      ],
    );
  }
}
