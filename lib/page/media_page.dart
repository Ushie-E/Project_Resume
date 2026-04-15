import 'package:flutter/material.dart';

import '../ui/common/const.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({Key? key}) : super(key: key);

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                'Contact Me',
                style: TextStyle(fontWeight: FontWeight.bold, color: kColor3),
              )
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('GitHub: https://github.com/Ushie08'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Twitter: https://twitter.com/AdarikuUshie'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                    'LinkedIn: https://www.linkedin.com/in/adrikushie08'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
