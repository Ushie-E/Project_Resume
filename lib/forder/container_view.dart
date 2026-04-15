import 'package:flutter/material.dart';
import 'package:project/ui/common/const.dart';
import 'package:project/page/media_page.dart';

import '../ui/common/widget/container_detail.dart';
import 'material_view.dart';

class ContainerView extends StatefulWidget {
  const ContainerView({
    Key? key,
  }) : super(key: key);

  @override
  State<ContainerView> createState() => _ContainerViewState();
}

class _ContainerViewState extends State<ContainerView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        color: kColor,
      ),
      height: 800,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ContainerDetail(),
              const MaterialView(),
              const MediaPage(),
              Center(
                child: ElevatedButton(
                  style: const ButtonStyle(),
                  onPressed: () {},
                  child: const Text('HIRE ME'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
