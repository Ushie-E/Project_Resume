import 'package:flutter/material.dart';
import 'package:project/ui/common/const.dart';

class ImagePicture extends StatefulWidget {
  final double radius;
  const ImagePicture({Key? key, required this.radius}) : super(key: key);

  @override
  State<ImagePicture> createState() => _ImagePictureState();
}

class _ImagePictureState extends State<ImagePicture> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: widget.radius,
        child: CircleAvatar(
          radius: widget.radius,
          backgroundColor: kColor,
          backgroundImage: const AssetImage(
            'images/ushie.png',
          ),
        ),
      ),
    );
  }
}
