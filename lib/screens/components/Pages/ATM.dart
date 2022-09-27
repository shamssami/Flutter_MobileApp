import 'package:flutter/material.dart';

class ATM extends StatelessWidget {
  ATM(
      {Key? key,
      required this.name,
      required this.distance,
      required this.status})
      : super(key: key);
  final String name;
  final String distance;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
