import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/flare_actor.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void navigationToNextPage() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void initState() {
    startSplashScreenTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Material(
      child: Stack(
        children: <Widget>[
          FlareActor("assets/flare/snow-mountain.flr",
              alignment: Alignment.center, fit: BoxFit.contain, animation: "idle")
        ],
      ),
    );
  }

  startSplashScreenTimer() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationToNextPage);
  }
}
