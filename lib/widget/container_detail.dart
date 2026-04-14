import 'package:flutter/material.dart';
import 'package:project/const.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ContainerDetail extends StatefulWidget {
  const ContainerDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<ContainerDetail> createState() => _ContainerDetailState();
}

class _ContainerDetailState extends State<ContainerDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 70,
        width: 900,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: kColor2),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Center(
            child: InkWell(
              onTap: () {
                _onBasicAlertPressed(context);
              },
              child: const Text(
                'Mobile Developer',
                style: TextStyle(fontSize: 30, color: kColor8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_onBasicAlertPressed(context) {
  var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: const TextStyle(fontWeight: FontWeight.bold),
      animationDuration: const Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: const BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: const TextStyle(
        color: kColor3,
      ),
      constraints: const BoxConstraints.expand(width: 300),
      overlayColor: Colors.black87,
      alertElevation: 0,
      alertAlignment: Alignment.topCenter);

  Alert(
    context: context,
    style: alertStyle,
    title: "Mobile Developer",
    desc: "I'm active and A Dynamic Mobile developer using Flutter/Dart.",
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        radius: BorderRadius.circular(19.0),
        child: const Text(
          "HIre me",
          style: TextStyle(color: kColor, fontSize: 20),
        ),
      ),
    ],
  ).show();
}
