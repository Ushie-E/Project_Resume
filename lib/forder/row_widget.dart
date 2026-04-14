import 'package:flutter/material.dart';

import '../const.dart';

class RowWidget extends StatefulWidget {
  final String text;
  final Icon icon;
  const RowWidget({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  State<RowWidget> createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(color: kColor, onPressed: () {}, icon: widget.icon),
        Text(
          widget.text,
          style: const TextStyle(fontSize: 18, color: kColor),
        )
      ],
    );
  }
}
