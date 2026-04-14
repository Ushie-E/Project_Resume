import 'package:flutter/material.dart';
import 'package:project/forder/row_widget.dart';
import 'package:project/page/real_view/rest_view.dart';
import 'package:project/widget/image_picture.dart';
import 'package:project/widget/text_description.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../const.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColor6,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kColor6,
      ),
      body: const RealView(),
      drawer: Drawer(
        backgroundColor: kColor8,
        child: Column(
          children: [
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ImagePicture(radius: 50),
                      ],
                    ),
                    TextDescription(
                      text: 'Contact',
                      write: 'info',
                    ),
                    RowWidget(
                      icon: Icon(Icons.mark_email_unread_outlined),
                      text: 'adarikushie00@gmail',
                    ),
                    RowWidget(
                      icon: Icon(Icons.phone),
                      text: '07011109498',
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _onBasicAlertPressed(context);
              },
              child: const Text(
                'About Me',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_onBasicAlertPressed(context) {
  Alert(
    context: context,
    title: "I'm a mobile Developer",
    desc:
        "Build awesome Application with Flutter by learning from great mind and working with real developer in the field",
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        child: const Center(
          child: Text(
            "Cool",
            textAlign: TextAlign.center,
            style: TextStyle(color: kColor, fontSize: 20),
          ),
        ),
      ),
    ],
  ).show();
}
