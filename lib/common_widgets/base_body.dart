import 'package:flutter/material.dart';

class BaseBody extends StatefulWidget {
  final Widget child;

  BaseBody({this.child});

  @override
  _BaseBodyState createState() => _BaseBodyState();
}

class _BaseBodyState extends State<BaseBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      extendBody: true,
      resizeToAvoidBottomPadding: false,
      body: Material(color: Colors.white, child: widget.child),
    );
  }
}
